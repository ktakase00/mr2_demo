class Reservation < ApplicationRecord
  has_many :reservation_users, inverse_of: :reservation
  accepts_nested_attributes_for :reservation_users, allow_destroy: true
  belongs_to :user
  belongs_to :meeting_room, required: false

  validates :title, presence: true
  validates :meeting_room_id, presence: true, numericality: {
    greater_than: 0,
    allow_blank: true,
  }

  validate :check_booking

  def self.new_instance
    truncated_at = Time.now.beginning_of_hour
    self.new({
      start_at: truncated_at,
      end_at: truncated_at + 1.hour
    })
  end

  private

  def check_booking
    return if self.meeting_room_id.blank? || self.meeting_room_id.to_i <= 0
    sql = <<-SQL
    SELECT
      EXISTS (
        SELECT
          1
        FROM
          reservations AS t1
        WHERE
          (:id IS NULL OR t1.id <> :id)
          AND t1.meeting_room_id = :meeting_room_id
          AND (
            ( :start_at <= t1.start_at AND :end_at > t1.start_at )
            OR ( :start_at < t1.end_at AND :end_at >= t1.end_at )
          )
      ) AS booked_flag
    SQL
    res = self.class.find_by_sql([sql, {
      id: self.id,
      meeting_room_id: self.meeting_room_id,
      start_at: self.start_at.to_s,
      end_at: self.end_at.to_s,
    }])
    if res.first.booked_flag
      self.errors.add(:meeting_room_id, I18n.t('errors.messages.booked'))
    end
  end
end
