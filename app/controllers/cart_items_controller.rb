class CartItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])
    @cart_item = @cart.add_product(product)

    if @cart_item.save
      redirect_back(fallback_location: root_path, notice: 'Товар додано в кошик 🛒')
    else
      redirect_back(fallback_location: root_path, alert: 'Не вдалося додати товар')
    end
  end

  # --- НОВИЙ МЕТОД ДЛЯ ЗМІНИ КІЛЬКОСТІ ---
  def update
    @cart_item = @cart.cart_items.find(params[:id])
    
    if @cart_item.update(quantity: params[:cart_item][:quantity])
      redirect_to cart_path, notice: "Кількість оновлено"
    else
      redirect_to cart_path, alert: "Помилка оновлення"
    end
  end
  # ---------------------------------------

  def destroy
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_back(fallback_location: cart_path, notice: 'Товар видалено.')
  end
end