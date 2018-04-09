class Format < ApplicationRecord
  has_many :detailed_films
  has_many :formats_screens
  has_many :screens, through: :formats_screens

  validates :name, presence: true
end
