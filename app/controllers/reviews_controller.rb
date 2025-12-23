class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_back(fallback_location: products_path, notice: "Відгук додано!")
    else
      redirect_back(fallback_location: products_path, alert: "Помилка! Перевірте, чи поставили ви оцінку.")
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end