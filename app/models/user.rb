class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :user_items, dependent: :destroy
  has_many :items, class_name: 'Item', foreign_key: 'item_id', through: :user_items, source: 'item'
  has_many :camps, dependent: :destroy
  has_one_attached :avatar
  has_many :likes, dependent: :destroy
  has_many :liked_camps, through: :likes, source: :camp

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true

  def already_liked?(camp)
    self.likes.exists?(camp_id: camp.id)
  end

  def is_guest_user?
    self.id == 13
  end
end
