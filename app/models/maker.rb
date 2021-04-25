class Maker < ApplicationRecord
  has_many :items

  validates :name, presence: true
  validates :name, uniqueness: true
  attribute :name, :string, default: '-'

end
