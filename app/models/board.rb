class Board < ApplicationRecord
  belongs_to :dashboard
  has_many :cards
end
