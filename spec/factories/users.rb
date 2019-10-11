FactoryBot.define do
  factory :user do
		name { "sample" }
		sequence(:email) { |n| "sample#{n}@gmail.com" }
		password { "sample" }
		password_confirmation { "sample" }
  end
end
