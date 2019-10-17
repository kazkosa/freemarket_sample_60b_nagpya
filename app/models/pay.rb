class Pay < ApplicationRecord
  belongs_to :user, optional: true

  # pay情報入力のバリデーション
  # 空の値はゆるさない
  validates :card_id, :year, :month, :security_number ,presence: true
  # 半角数値制限
  validates :card_id, :year, :month, :security_number, format: { with: /\A[0-9]+\z/ }
  # 字数制限
  validates :card_id, length: { maximum: 10 }
  validates :year, :month, length: { maximum: 2 }
  validates :security_number, length: { maximum: 4 }
end
