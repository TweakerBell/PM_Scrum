class Card < ApplicationRecord
  belongs_to :board
  belongs_to :sprint, optional: true
  has_many :sprint_cards
  has_many :estimation_rounds
  has_many :acceptance_criteriums
end
