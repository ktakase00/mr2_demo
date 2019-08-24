class Reservation < ApplicationRecord
  has_many :reservation_users, inverse_of: :reservation
  belongs_to :user
  belongs_to :meeting_room, required: false

  validates :title, presence: true
  validates :meeting_room_id, presence: true, numericality: {
    greater_than: 0,
    allow_blank: true,
  }

  def self.new_instance
    truncated_at = Time.now.beginning_of_hour
    self.new({
      start_at: truncated_at,
      end_at: truncated_at + 1.hour
    })
  end
end
