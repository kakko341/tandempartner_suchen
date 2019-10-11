FactoryBot.define do
  factory :message do
    title { "sample" }
  	content { "sample@content" }
  	association :user
  end
end
