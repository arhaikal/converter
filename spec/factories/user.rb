FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "#{FFaker::Internet.email}" }
    password ( Devise.friendly_token.first(8) )
  end

end
