class CampItem < ApplicationRecord
  belongs_to :camp
  belongs_to :item
  validates :camp_id, uniqueness: { scope: :item_id }

end
