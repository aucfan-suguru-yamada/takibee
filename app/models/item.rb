class Item < ApplicationRecord
  has_many :user_items, dependent: :destroy
  has_many :camp_items, dependent: :destroy
  has_many :users, class_name: 'User', foreign_key: 'user_id', through: :user_items, source: 'user'
  has_one_attached :small_image
  belongs_to :maker
#  accepts_nested_attributes_for :maker

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :by_maker, ->(maker_id) { where(maker_id: maker_id) }
  scope :own_user, ->(user_id) {joins(:user_items).where('user_id = ?', user_id)}

end
