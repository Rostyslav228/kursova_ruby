class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart
  before_action :authenticate_user!

  def show
    if current_user.admin?
      @order = Order.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end
  end

  def new
    if @cart.cart_items.empty?
      redirect_to root_path, alert: "Ваш кошик порожній"
      return
    end

    @order = Order.new
    if current_user
      @order.first_name = current_user.first_name
      @order.last_name = current_user.last_name
      @order.phone = current_user.phone
      @order.city = current_user.city
      @order.address = current_user.address
    end
  end

  # --- РЕДАГУВАННЯ ЗАМОВЛЕННЯ ---
  def edit
    @order = current_user.orders.find(params[:id])
    
    # Забороняємо редагувати, якщо замовлення вже не "Нове"
    if @order.status != "Нове"
      redirect_to dashboard_path, alert: "Це замовлення вже обробляється, його не можна змінити."
    end
  end
  # --------------------------------

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.status = "Нове"
    @order.total_price = @cart.total_price

    if @order.save
      @cart.cart_items.each do |item|
        @order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          price: item.product.price
        )
      end

      current_user.update(
        first_name: @order.first_name,
        last_name: @order.last_name,
        phone: @order.phone,
        city: @order.city,
        address: @order.address
      )

      @cart.destroy
      session[:cart_id] = nil

      redirect_to order_path(@order), notice: "Дякуємо! Ваше замовлення прийнято."
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  # --- ОНОВЛЕНИЙ МЕТОД UPDATE (ВИПРАВЛЕНИЙ) ---
  def update
    @order = Order.find(params[:id])

    # 1. ЛОГІКА ДЛЯ АДМІНА (Зміна статусу)
    # Ми перевіряємо, чи прийшов статус у params[:status] або у params[:order][:status]
    # Це виправляє помилку "undefined method [] for nil:NilClass"
    incoming_status = params[:status] || (params[:order] && params[:order][:status])

    if current_user.admin? && incoming_status.present?
      if @order.update(status: incoming_status)
        redirect_back(fallback_location: dashboard_path, notice: "Статус оновлено.")
      else
        redirect_back(fallback_location: dashboard_path, alert: "Помилка оновлення.")
      end
      return # Виходимо, щоб не виконувати код для користувача
    end

    # 2. ЛОГІКА ДЛЯ КОРИСТУВАЧА (Редагування даних та товарів)
    if @order.user == current_user
      if @order.status == "Нове"
        if @order.update(order_params)
          redirect_to dashboard_path, notice: "Замовлення оновлено успішно."
        else
          render :edit, status: :unprocessable_entity
        end
      else
        redirect_to dashboard_path, alert: "Замовлення вже в обробці, редагування заборонено."
      end
    else
      redirect_to root_path, alert: "У вас немає прав."
    end
  end
  # ----------------------------------------------------------

  def add_review
    @order = current_user.orders.find(params[:id])
    if @order.update(rating: params[:rating], review: params[:review])
      redirect_back(fallback_location: dashboard_path, notice: "Дякуємо за ваш відгук! ⭐")
    else
      redirect_back(fallback_location: dashboard_path, alert: "Не вдалося зберегти відгук.")
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :first_name, :last_name, :phone, :city, :address, :shipping_method, :payment_method, :status,
      :rating, :review,
      # Дозволяємо вкладені атрибути для редагування кількості та видалення товарів
      order_items_attributes: [:id, :quantity, :_destroy]
    )
  end
end