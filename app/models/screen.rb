class Screen < ApplicationRecord
  after_initialize :build_std_format

  has_many :formats_screens
  has_many :formats, through: :formats_screens
  has_many :screenings

  validates :capacity, presence: true

  private

  def build_std_format
    formats.build(name: 'standard')
  end

  # add address
end
