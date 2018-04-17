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
  validate :must_have_cnpj_iff_owner

  private

  def must_have_cnpj_iff_owner
    errors.add(:cnpj, 'must be theater owner') unless role == 'theater_owner' || cnpj.nil?
    errors.add(:role, 'must have CNPJ') if role == 'theater_owner' && cnpj.nil?
  end

end
