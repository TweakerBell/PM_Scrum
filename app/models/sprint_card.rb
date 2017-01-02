class SprintCard < ApplicationRecord
  has_many :estimation_rounds
  belongs_to :sprint_board
end
