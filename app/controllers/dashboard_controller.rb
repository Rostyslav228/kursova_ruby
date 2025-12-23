class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  # --- 1. ПІДКЛЮЧАЄМО ЛОГІКУ КОШИКА ---
  include CurrentCart
  before_action :set_cart

  def index
    # --- ДЛЯ КЛІЄНТА ---
    @orders = current_user.orders.order(created_at: :desc)
    
    # Обрані товари
    @favorites = current_user.favorite_products
    
    # --- 2. ТОВАРИ В КОШИКУ (НОВЕ) ---
    # Завантажуємо товари кошика разом з інфою про продукт, щоб не було зайвих запитів до БД
    @cart_items = @cart.cart_items.includes(:product)

    # --- ДЛЯ АДМІНА ---
    if current_user.admin?
      @admin_orders = Order.includes(:user).all.order(created_at: :desc)
      @rated_orders = Order.where.not(rating: nil).order(updated_at: :desc)
      @reviews_count = @rated_orders.count
      # Лічильники статусів
      @new_orders_count = Order.where(status: [nil, 'Нове']).count
      @processing_count = Order.where(status: ['В обробці', 'Комплектується']).count
      @done_count = Order.where(status: ['Відправлено', 'Виконано']).count

      # --- ФІНАНСИ ---
      # Беремо тільки успішні замовлення
      completed_orders = Order.where(status: ['Виконано', 'Відправлено'])
      
      # 1. Загальний дохід (сума всіх успішних)
      @total_revenue = completed_orders.sum(:total_price) || 0
      
      # 2. Середній чек (Дохід / кількість успішних)
      @average_check = @done_count > 0 ? (@total_revenue / @done_count) : 0
    end
  end
end