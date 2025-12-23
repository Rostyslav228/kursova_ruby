class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  
  # 1. Дозволяємо редагувати order_items прямо з форми замовлення
  # allow_destroy: true - дозволяє видаляти товари (якщо передати галочку _destroy)
  accepts_nested_attributes_for :order_items, allow_destroy: true

  # Статуси
  STATUSES = ["Нове", "В обробці", "Відправлено", "Виконано", "Скасовано"]

  validates :first_name, :last_name, :phone, :address, :city, presence: true

  # 2. Перераховуємо суму перед збереженням, якщо змінилася кількість
  before_save :calculate_total_price

  private

  def calculate_total_price
    # Сумуємо (ціна * кількість) для всіх товарів, які НЕ позначені на видалення
    self.total_price = order_items.reject(&:marked_for_destruction?).sum { |item| item.price * item.quantity }
  end
end