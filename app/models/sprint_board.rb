class SprintBoard < ApplicationRecord
  belongs_to :sprint
  has_many :sprint_cards
end
