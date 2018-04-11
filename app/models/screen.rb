class Screen < ApplicationRecord
  before_save :build_std_format

  has_many :formats_screens
  has_many :formats, through: :formats_screens
  has_many :screenings
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :capacity, presence: true

  # This method ensures the owner sees an intelligible string rather than a
  # jumble of an Object in the screening#new page.
  def prepare_for_display
    ["#{name} (#{capacity} seats)", "#{id}"]
  end

  private

  def build_std_format
    formats << Format.find_by(name: 'standard')
  end
end
