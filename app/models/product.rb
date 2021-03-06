class Product < ApplicationRecord
  belongs_to :category 
  has_many :product_images, dependent: :destroy
  has_many :likes,          dependent: :delete_all
  has_many :comments,       dependent: :delete_all
  belongs_to :user
  belongs_to :buyer, class_name: "User", optional: true
  accepts_nested_attributes_for :product_images
  validates :title,:category_id,:shipping_charges,:shipping_area,:shipping_date,
            :shipping_method,:price,:size,:description,:condition,presence: true
  validates :price, numericality: { greater_than_or_equal_to: 300  }
  validates :price, numericality: { less_than_or_equal_to: 9999999 }
  enum condition:         ["新品、未使用","未使用に近い","目立った傷や汚れなし","やや傷や汚れあり","傷や汚れあり","全体的に状態が悪い"]
  enum shipping_charges:  ["送料込み(出品者負担)","着払い(購入者負担)"]
  enum shipping_date:     ["1~2日で発送","2~3日で発送","4~7日で発送"]
  enum shipping_method:   ["未定","クロネコヤマト","ゆうパック","ゆうメール"]
  enum size:              ["XXS以下","XS(SS)","S","M","L","XL(LL)","2XL(3L)","3XL(4L)","4XL(5L)以上","FREE SIZE"]
  enum state:              { in_sale: 0, waiting_for_shipping: 1, on_delivery: 2, arrived: 3, completed: 10, pending: 99 }

  def state_transition(state)
    self.update(state: state)
  end
end