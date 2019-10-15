class Product < ApplicationRecord
  belongs_to :category 
  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images 
end
