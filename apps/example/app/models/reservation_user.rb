class ReservationUser < ApplicationRecord
  belongs_to :reservation, inverse_of: :reservation_users
  belongs_to :user
end
