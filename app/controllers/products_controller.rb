class ProductsController < ApplicationController
  # 1. Дозволяємо переглядати каталог (index) і товар (show) навіть без реєстрації
  before_action :authenticate_user!, except: [:index, :show]
  
  # 2. Перевіряємо, чи ти Адмін, перед тим як дати створити/змінити товар
  before_action :ensure_admin!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @products = Product.all

    # --- ЛОГІКА ФІЛЬТРІВ ---
    
    # Фільтр по категорії (ID)
if params[:category_id].present?
  category = Category.find_by(id: params[:category_id])
  # Якщо вибрали головну категорію (наприклад "Одяг"), показуємо і товари з підкатегорій (футболки, штани)
  if category && category.subcategories.any?
    ids = category.subcategories.pluck(:id) + [category.id]
    @products = @products.where(category_id: ids)
  else
    @products = @products.where(category_id: params[:category_id])
  end
end

    # Фільтр по ціні (від - до)
    if params[:min_price].present?
      @products = @products.where("price >= ?", params[:min_price])
    end
    
    if params[:max_price].present?
      @products = @products.where("price <= ?", params[:max_price])
    end
    
    # Сортування (Спочатку нові)
    @products = @products.order(created_at: :desc)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    # ТУТ БУЛА ПОМИЛКА: використовувався product_params, який шукав title
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to products_path, notice: "Товар успішно створено!"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    
    if @product.update(product_params)
      redirect_to products_path, notice: "Товар оновлено!"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "Товар видалено."
  end

  private

def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :category_id, :sizes, :brand, :old_price, images: [])
  end

  # Функція захисту: якщо не адмін -> на головну
  def ensure_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "У вас немає прав для цієї дії."
    end
  end
end