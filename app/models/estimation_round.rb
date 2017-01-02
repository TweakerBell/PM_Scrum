class EstimationRound < ApplicationRecord
  belongs_to :sprint_card
  has_many :estimated_works
  has_many :work_comments
end
