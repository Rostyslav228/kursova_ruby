class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  # Метод: додати товар (якщо вже є - збільшити кількість, якщо ні - створити новий)
  def add_product(product)
    current_item = cart_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(product_id: product.id, quantity: 1)
    end
    current_item
  end

  # Метод: повна ціна кошика
  def total_price
    cart_items.sum { |item| item.quantity * item.product.price }
  end
end