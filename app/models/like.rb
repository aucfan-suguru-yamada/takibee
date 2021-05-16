class Like < ApplicationRecord
  belongs_to :camp
  belongs_to :user
  validates_uniqueness_of :camp_id, scope: :user_id
end
