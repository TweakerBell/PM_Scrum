class EstimationRound < ApplicationRecord
  belongs_to :sprint_card, optional: true
  belongs_to :card, optional: true
  has_many :estimated_works
  has_many :work_comments

end
