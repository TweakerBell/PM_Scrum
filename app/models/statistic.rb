class Statistic < ApplicationRecord
  belongs_to :sprint, optional: true
  belongs_to :dashboard, optional: true
end
