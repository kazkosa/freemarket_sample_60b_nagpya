class Product < ApplicationRecord
  belongs_to :category 
  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images 

  validates :title, presence: true
  validates :category_id, presence: true
  validates :shipping_charges, presence: true
  validates :shipping_area, presence: true
  validates :shipping_date, presence: true
  validates :shipping_method, presence: true
  validates :price, presence: true
  validates :size, presence: true
  validates :description, presence: true
  validates :condition, presence: true
end