FactoryBot.define do
  factory :favorite do
    message
    user { message.user }
  end
end
