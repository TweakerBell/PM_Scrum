class Dashboard < ApplicationRecord
  belongs_to :project
  has_many :boards
  has_many :sprints
  has_many :statistics
  has_many :roadmap_rows
end
