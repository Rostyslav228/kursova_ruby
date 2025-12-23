class Product < ApplicationRecord
  has_many_attached :images


  belongs_to :category, optional: true
  

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }


  has_many :favorites, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :order_items
end