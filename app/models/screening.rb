class Screening < ApplicationRecord
  belongs_to :detailed_film
  belongs_to :screen
end
