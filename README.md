# README

#　DB設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null:false, unique: true|
|email|string|null:false, unique:true, /\A\S+@\S+\.\S+\z/(email)|
|password|string|null:false, /\A[a-zA-Z0-9]+\z/(半角アルファベット、数値のみ)|
|family_name|string|null:false|
|first_name|string|null:false|
|family_name_kana|string|null:false, /\A[ァ-ヶー－]+\z/(全角カタカナのみ)|
|first_name_kana|string|null:false, /\A[ァ-ヶー－]+\z/(全角カタカナのみ)|
|birthday_year|integer|null:false|
|birthday_month|integer|null:false|
|birthday_day|integer|null:false|

### Association
- has_many :products
- has_many :likes, dependent: :delete_all
- has_many :comments, dependent: :delete_all
- has_one :address
- accepts_nested_attributes_for :address 
- has_many :cards
- has_one :pay
- accepts_nested_attributes_for :pay
- has_many :buyed_products,                                         foreign_key: "buyer_id", class_name: "Product"
- has_many :selling_products,  -> { where("buyer_id is NULL") },    foreign_key: "user_id", class_name: "Product"
- has_many :sold_products,     -> { where("buyer_id is not NULL")}, foreign_key: "user_id", class_name: "Product"


## addressテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|prefectures|string|null: false|
|municipalities|string|null: false|
|block_number|string|null: false|
|building|string|
|phone_number|integer|

## Association
- belong_to :user

## enum
- prefectures

## cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|card_id|integer|null: false|

## Association
- belongs_to :user

## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|product|references|null: false, foreign_key: true|
|body|text|null: false|

## Association
- belongs_to :user
- belongs_to :product

## Association
- has_many :users
- has_many :products

## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|product|references|null: false, foreign_key: true|

## Association
- belongs_to :user
- belings_to :product

## prodocts

|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|user|references|null: false, foreign_key: true|
|category|references|null: false, foreign_key: true|
|bland|references|null: false, foreign_key: true|
|shipping_charges|string|null: false|
|shipping_area|string|null: false|
|shipping_date|string|null: false|
|shipping_method|string|null: false|
|price|integer|null: false|
|size|string|null: false|
|description|string|
|condeition|string|null: false|
|buyer_id|references|null: false, foreign_key: { to_table: :users }|
|condeition|integer||

## Association
- belongs_to :category 
- has_many :product_images, dependent: :destroy
- has_many :likes,          dependent: :delete_all
- has_many :comments,       dependent: :delete_all
- belongs_to :user
- belongs_to :buyer, class_name: "User", optional: true
- accepts_nested_attributes_for :product_images


## enum
- condition
- shipping_charges
- shipping_date
- shipping_method
- size
- state

## product_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key: true|
|image|text|null: false|

##Assosiation
- belongs_to :product

## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

## Assosiation
- has_many :products

## categorysテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|path|integer|null: false|
## Assosiation
- has_many :products  
(gem acenstryを使用)

