class Screen < ApplicationRecord
  after_initialize :build_std_format

  has_many :formats_screens
  has_many :formats, through: :formats_screens
  has_many :screenings
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :capacity, presence: true

  private

  def build_std_format
    formats << Format.find_by(name: 'standard')
  end
end
