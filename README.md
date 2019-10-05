# README

#DB設計

~~~
## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null:false|
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
- has_one :adeles
- has_one :pay
- has_many :coments
- belong_to :deal
- has_many :products through:deals

## addressテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|prefectures|string|null: false|
|municipalities|string|null: false|
|address|string|null: false|
|building|string|
|phone_number|integer|

## Association
- belong_to :user

## paysテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|card_id|integer|null: false|
|year|integer|null: false|
|month|integer|null: false|
|security_number|integer|null: false|

## Association
- belong_to :user

## comentsテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|product|references|null: false, foreign_key: true|
|body|text|

## Association
- belong_to :coment
- belong_to :product

## dealsテーブル

|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key: true|
|seller_id|references|null: false, foreign_key: { to_table: :users }|
|buyer_id|references|null: false, foreign_key: { to_table: :users }|

## Association
- has_many :users
- has_many :products

## likeテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|product|references|null: false, foreign_key: true|

## Association
- belong_to :user
- beling_to :product

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
- has_many :images
- has_many :coments
- has_many :likes
- belong_to :deal
- belong_to :brand
- belong_to :l_cotegory
- has_many :users through:deals

## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key: true|
|image|text|null: false|

##Assosiation
- belong_to :product

## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

## Assosiation
- has_many :products

## l_categorysテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

## Assosiation
- has_many :products
- has_many :m_categorys

## m_categorysテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|l_categorys|references|null: false, foreign_key: true|

## Assosiation
= belong_to :l_category
- has_many :s_category

## s_categorysテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|m_categorys|references|null: false, foreign_key: true|

## Assosiation
= belong_to :m_category


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
