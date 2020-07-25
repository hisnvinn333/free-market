class Item < ApplicationRecord

  validates :name, :price, :detail, :condition, :delivery_fee_payer, :delivery_method, :delivery_days, :deal, presence: true
  validates :price, numericality:{greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
  belongs_to :category

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  class CreateItems < ActiveRecord::Migration[6.0]
    def change
      create_table :items do |t|
        t.string     :name, null: false, index:true  ## 商品名
        t.integer    :price, null:false              ## 価格
        t.text       :detail, null:false             ## 紹介文
        t.integer    :condition, null:false          ## 状態（中古、新品など）
        t.integer    :delivery_fee_payer, null:false ## 送料負担者
        t.integer    :delivery_method, null:false    ## 配送方法
        t.integer    :prefecture_id, null:false, default: 0    ## 配送元地域
        t.integer    :delivery_days, null:false      ## 配送にかかる日数
        t.integer    :deal, default: 0                           ## 販売状況
        t.references :category, null:false, foreign_key: true
        t.references :seller, null:false, foreign_key: { to_table: :users }
        t.references :buyer, foreign_key: { to_table: :users }
        t.timestamps
      end
    end
  end  
  enum condition:{
    "新品、未使用": 0,
    "未使用に近い": 1,
    "目立った傷や汚れなし": 2,
    "やや傷や汚れあり": 3,
    "傷や汚れあり": 4,
    "全体的に状態が悪い": 5
    }
  
  enum delivery_fee_payer:{
    "送料込み（出品者負担）": 0,
    "着払い（購入者負担）": 1
    }
  
  enum delivery_method:{
    "未定": 0,
    "らくらくメルカリ便": 1,
    "ゆうメール": 2,
    "レターパック": 3,
    "普通郵便（定形、定形外）": 4,
    "クロネコヤマト": 5,
    "ゆうパック": 6,
    "クリックポスト": 7,
    "ゆうパケット": 8
    }
  
  enum delivery_days:{
    "1〜2日で発送": 0,
    "2〜3日で発送": 1,
    "4〜7日で発送": 2
    }
  
  enum deal:{
    "販売中": 0,
    "売り切れ": 1
    }
end

