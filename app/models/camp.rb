class Camp < ApplicationRecord
  has_many :items
  belongs_to :user
  has_many :camp_items, dependent: :destroy
  has_many :items, class_name: 'Item', foreign_key: 'item_id', through: :camp_items, source: 'item'
  has_many_attached :images
  has_one :area
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :title, presence: true
  validate :images_size

  def images_size
    images.each do |image|
      if image.blob.byte_size > 5.megabytes
        errors.add(:avatars, "は1つのファイル5MB以内にしてください")
      end
    end
  end
end
