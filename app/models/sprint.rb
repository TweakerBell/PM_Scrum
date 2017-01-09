class Sprint < ApplicationRecord
  belongs_to :dashboard
  has_many :sprint_boards
  has_many :cards
  has_one :statistic
  has_many :sprint_retro_comments
end
