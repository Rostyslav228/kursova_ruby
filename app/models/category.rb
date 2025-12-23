class Category < ApplicationRecord
  # Вказуємо, що категорія може мати "батька" (іншу категорію)
  belongs_to :parent, class_name: "Category", optional: true
  
  # Вказуємо, що категорія може мати підкатегорії
  has_many :subcategories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  
  # Зв'язок з товарами
  has_many :products
end