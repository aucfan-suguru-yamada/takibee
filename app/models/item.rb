class Item < ApplicationRecord
  has_many :user_items
  has_many :users, class_name: 'User', foreign_key: 'user_id', through: :user_items, source: 'user'
  has_one_attached :small_image
end
