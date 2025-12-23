class CartsController < ApplicationController
  def show
    # Просто показуємо сторінку кошика
  end

  def destroy
    # Очистити весь кошик
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path, notice: 'Кошик очищено'
  end
end