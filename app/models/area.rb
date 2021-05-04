class Area < ApplicationRecord
  belongs_to :camp
  validates :name, presence: true
  validates :address, presence: true
end
