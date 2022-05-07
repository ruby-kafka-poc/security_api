# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Lorem.sentence }
    access_at { rand(99).days.ago }
    failed_attempts { rand(3) }
    locked { false }
  end
end
