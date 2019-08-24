class MeetingRoom < ApplicationRecord
  validates :meeting_room_nm, presence: true
end
