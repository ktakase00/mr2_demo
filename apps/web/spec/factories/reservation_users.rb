FactoryBot.define do
  factory :reservation_user do
    reservation_id { "" }
    user_id { "" }
    attendance_flag { false }
  end
end
