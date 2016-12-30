class Project < ApplicationRecord
  has_one :dashboard
  has_and_belongs_to_many :users
end
