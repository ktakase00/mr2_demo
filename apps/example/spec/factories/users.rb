FactoryBot.define do
  sequence :user_cd do |n|
    "user#{n}"
  end

  sequence :user_nm do |n|
    "User#{n}"
  end

  factory :user do
    user_cd
    user_nm
  end
end
