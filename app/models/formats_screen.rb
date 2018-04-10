class FormatsScreen < ApplicationRecord
  belongs_to :format
  belongs_to :screen

  validates :format, presence: true
  validates :screen, presence: true

  # Uniqueness
end
