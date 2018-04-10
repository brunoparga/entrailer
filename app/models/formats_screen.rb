class FormatsScreen < ApplicationRecord
  belongs_to :format
  belongs_to :screen

  validates :screen, presence: true
  validates :format,
            presence: true,
            uniqueness: { scope: :screen,
                          message: 'should be unique per screen' }
end
