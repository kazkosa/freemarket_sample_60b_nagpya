class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products
  has_many :likes, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_one :address
  accepts_nested_attributes_for :address 
  has_many :cards
  has_one :pay
  accepts_nested_attributes_for :pay

  has_many :buyed_products,                                         foreign_key: "buyer_id", class_name: "Product"
  has_many :selling_products,  -> { where("buyer_id is NULL") },    foreign_key: "user_id", class_name: "Product"
  has_many :sold_products,     -> { where("buyer_id is not NULL")}, foreign_key: "user_id", class_name: "Product"
  
  # user情報入力バリデーション
    # 値が空ではない
      validates :nickname, :email, :password, :password_confirmation, :family_name, :first_name,
                :family_name_kana, :first_name_kana, :birthday_year, :birthday_month, :birthday_day, presence: true
      validates :password, confirmation: true
    # 苗字、名前は全角のカタ、ひら、漢字のどれかである
      validates :family_name, format:{ with: /\A[ぁ-んァ-ン一-龥]/ }
      validates :first_name, format:{ with: /\A[ぁ-んァ-ン一-龥]/ }
    # フリガナは全角カタカナである
      validates :family_name_kana, format:{ with: /\A[ァ-ヶー－]+\z/ }
      validates :first_name_kana, format:{ with: /\A[ァ-ヶー－]+\z/ }
    # 数値範囲指定  
      validates :birthday_year, numericality:{ greater_than_or_equal_to: 1930 }
      validates :birthday_year, numericality:{ less_than_or_equal_to: 2018 }
      validates :birthday_month, numericality:{greater_than_or_equal_to: 1 }
      validates :birthday_month, numericality:{less_than_or_equal_to: 12 }
      validates :birthday_day, numericality:{greater_than_or_equal_to: 1 }
      validates :birthday_day, numericality:{less_than_or_equal_to: 31 }     
end
