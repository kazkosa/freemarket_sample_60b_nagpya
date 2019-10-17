class Product < ApplicationRecord
  belongs_to :category 
  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images 

  validates :title,:category_id,:shipping_charges,:shipping_area,:shipping_date,
            :shipping_method,:price,:size,:description,:condition,presence: true 
end