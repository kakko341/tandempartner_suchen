FactoryBot.define do
  factory :comment do
  	content { "sample@content" }
  	association :user
  	association :message
  end
end
