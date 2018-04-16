class Screen < ApplicationRecord
  before_create :build_std_format

  has_many :formats_screens
  has_many :formats, through: :formats_screens
  has_many :screenings
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :capacity, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch
  pg_search_scope :search_by_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true }
      #:ignoring => :accents
    }

  # This method ensures the owner sees an intelligible string rather than a
  # jumble of an Object in the screening#new page.
  def prepare_for_display
    ["#{name} (#{capacity} seats)", "#{id}"]
  end

  private

  def build_std_format
    formats << Format.find_by(name: 'convencional')
  end
end
