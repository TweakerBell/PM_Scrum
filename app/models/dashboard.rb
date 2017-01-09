class Dashboard < ApplicationRecord
  belongs_to :project
  has_many :boards
  has_many :sprints
end
