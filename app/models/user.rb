class User < ApplicationRecord
  # 1. Налаштування Devise
  # ВАЖЛИВО: authentication_keys має бути [:phone], бо колонка в базі називається phone
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:phone] 

  # 2. Валідації
  # Перевіряємо саме :phone (не phone_number)
  validates :phone, presence: true, uniqueness: true
  validates :email, uniqueness: true, allow_blank: true

  # 3. Зв'язки (Associations)
  has_many :favorites, dependent: :destroy
  has_many :favorite_products, through: :favorites, source: :product
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # 4. Методи для вимкнення обов'язкової пошти
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end