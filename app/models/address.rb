class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true

  #address情報入力のバリデーション
  # 空の値はゆるさない
  validates :post_num, :prefectures, :municipalities, :block_number ,presence: true
  # 半角数値以外許さない
  validates :phone_number, format: { with: /\A[0-9]+\z/ }
  validates :post_num, format: { with: /\A[0-9]+\z/ }
end