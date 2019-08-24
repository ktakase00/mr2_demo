class User < ApplicationRecord
  validates :user_cd, presence: true
  validates :user_nm, presence: true

  after_create :update_reservation_users

  def update_reservation_users
    list = Reservation.select(:id)

    list.each do |reservation|
      reservation_user = ReservationUser.new({
        reservation_id: reservation.id,
        user_id: self.id,
      })
      reservation_user.save
    end
  end
end
