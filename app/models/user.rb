class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable



  has_many  :accounts
  has_many :transactions, through: :accounts

  after_initialize :set_default_role, :if => :new_record?

  ROLES = {
      0 => :admin,
      1 => :client
  }

  def admin?
    self.role == ROLES.invert[:admin]
  end

  def set_default_role
    self.role ||= :user
  end

end
