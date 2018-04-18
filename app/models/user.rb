class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum role: [:user, :theater_owner, :admin]

  has_many :tickets
  has_many :screens

  validates :first_name, presence: true, length: { minimum: 1 }
  validates :last_name, presence: true, length: { minimum: 1 }
  validates :cnpj, presence: true, if: :is_owner?
  validates :address, presence: true, if: :is_owner?

  def is_owner?
    role == 'theater_owner'
  end
end
