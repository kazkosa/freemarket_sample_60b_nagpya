class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address
  accepts_nested_attributes_for :address 
  has_many :cards
  has_one :pay
  accepts_nested_attributes_for :pay   
  
  # user情報入力バリデーション
    # 値が空ではない
      validates :nickname, :email, :password, :password_confirmation, :family_name, :first_name,
                :family_name_kana, :first_name_kana, :birthday_year, :birthday_month, :birthday_day,presence: true
    # passwordとpassword_confirmationは値が一緒である
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
