class Sprint < ApplicationRecord
  belongs_to :dashboard
  has_many :sprint_boards
end
