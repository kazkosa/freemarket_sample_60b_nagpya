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
- has_one :adeles, dependent: delete_all
- has_one :pay, dependent: delete_all
- has_many :comments, dependent: delete_all
- has_many :likes, dependent: delete_all
- belongs_to :deal
- has_many :products through:deals ,dependent: delete_all

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

## paysテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|card_id|integer|null: false|
|year|integer|null: false|
|month|integer|null: false|
|security_number|integer|null: false|

## Association
- belongs_to :user

## comentsテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|product|references|null: false, foreign_key: true|
|body|text|null: false|

## Association
- belongs_to :user
- belongs_to :product

## dealsテーブル

|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key: true|
|seller_id|references|null: false, foreign_key: { to_table: :users }|
|buyer_id|references|null: false, foreign_key: { to_table: :users }|

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

## Association
- has_many :images, dependent: delete_all
- has_many :comments, dependent: delete_all
- has_many :likes, dependent: delete_all
- belongs_to :deal
- belongs_to :brand
- belongs_to :cotegory
- has_many :users through:deals

## enum
- shipping_charges
- shipping_area
- shipping_date
- shipping_method
- size
- condeition

## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key: true|
|product_images|text|null: false|

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



This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
