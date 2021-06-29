class Like < ApplicationRecord
  belongs_to :camp
  belongs_to :user
  validates :camp_id, uniqueness: { scope: :user_id }
end
