class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sold_tickets
  validates :address, presence: true
  has_many :screens

  enum role: [:user, :theater_owner, :admin]

end
