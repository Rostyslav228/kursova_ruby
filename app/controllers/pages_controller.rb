class PagesController < ApplicationController
  def home
    # Беремо 4 останні додані товари
    @new_products = Product.order(created_at: :desc).limit(4)
    
    # Беремо основні категорії (для блоку категорій)
    if defined?(Category)
      @main_categories = Category.where(parent_id: nil).limit(3)
    else
      @main_categories = []
    end
  end
end