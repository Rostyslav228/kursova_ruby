class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :product
  # Щоб не можна було лайкнути один товар двічі
  validates :user_id, uniqueness: { scope: :product_id }
end