class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])
    current_user.favorites.create(product: product)
    redirect_back(fallback_location: products_path, notice: "Додано в обране ❤️")
  end

  def destroy
    product = Product.find(params[:product_id])
    favorite = current_user.favorites.find_by(product_id: product.id)
    favorite&.destroy
    redirect_back(fallback_location: products_path, notice: "Видалено з обраного 💔")
  end
end