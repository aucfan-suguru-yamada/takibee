class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :user_items, dependent: :destroy
  has_many :items, class_name: 'Item', foreign_key: 'item_id', through: :user_items, source: 'item'
  has_many :camps, dependent: :destroy
  has_one_attached :avatar
  has_many :likes, dependent: :destroy
  has_many :liked_camps, through: :likes, source: :camp

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true
  validate :avatar_size

  include CampHelper


  def already_liked?(camp)
    likes.exists?(camp_id: camp.id)
  end

  def is_guest_user?
    email == 'guest_user@example.com'
  end

  def is_admin_user?
    id == 1
  end

  def avatar_size
    if avatar.present? && (avatar.blob.byte_size > 5.megabytes)
      errors.add(:avatar, 'は1つのファイル5MB以内にしてください')
    end
  end

  def get_range_of_camparea
    user_camps = self.camps.includes(:area)
    max_latitude = 0
    min_latitude = 90
    max_longitude = 0
    min_longitude = 180
    radar_range_of_area = 0
    user_camps.each do |camp|
      if camp.area.present?
        latitude = split_lat(camp.area.latlng).to_i
        longitude = split_lng(camp.area.latlng).to_i
        max_latitude = latitude if latitude > max_latitude
        max_longitude = longitude if longitude > max_longitude
        min_latitude = latitude if latitude < min_latitude
        min_longitude = longitude if longitude < min_longitude
      end
      radar_range_of_area = (((max_latitude - min_latitude)**2 + (max_longitude - min_longitude)**2)**0.5)
    end
    radar_range_of_area = 0 if max_latitude.zero?
    radar_range_of_area
  end

  def get_camp_by_liked
    user_camps = self.camps
    radar_camp_by_liked = 0
    user_camps.each do |camp|
      radar_camp_by_liked += camp.likes.count
    end
    radar_camp_by_liked
  end

end
