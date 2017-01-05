class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :projects
  enum role: [:stakeholder, :product_owner, :scrum_master, :scrum_team]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :stakeholder
  end
end
