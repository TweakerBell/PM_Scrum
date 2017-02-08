class RoadmapRow < ApplicationRecord
  belongs_to :dashboard
  has_many :roadmap_items
end
