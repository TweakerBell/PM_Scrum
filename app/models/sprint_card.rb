class SprintCard < ApplicationRecord
  has_many :estimation_rounds
  belongs_to :sprint_board, optional: true
  belongs_to :card, optional: true
  has_many :change_requests
end
