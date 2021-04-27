class Camp < ApplicationRecord
  has_many :items
  belongs_to :user
  has_many :camp_items, dependent: :destroy
  has_many :items, class_name: 'Item', foreign_key: 'item_id', through: :camp_items, source: 'item'
  has_many_attached :images


  validates :title, presence: true
end
