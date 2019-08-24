FactoryBot.define do
  sequence :title do |n|
    "Meeting#{n}"
  end

  factory :reservation do
    title
    user_id { "" }
    meeting_room_id { "" }
    start_at { Time.now }
    end_at { Time.now + 1.hour }
    memo_content { "MyText" }
  end
end
