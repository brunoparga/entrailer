class SoldTicket < ApplicationRecord
  belongs_to :screening
  belongs_to :user
end
