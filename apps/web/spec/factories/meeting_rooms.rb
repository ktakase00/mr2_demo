FactoryBot.define do
  sequence :meeting_room_nm do |n|
    "Meeting Room#{n}"
  end

  factory :meeting_room do
    meeting_room_nm
    memo_content { "MyText" }
  end
end
