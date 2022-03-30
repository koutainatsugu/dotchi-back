# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :user do
    provider { "twitter" }
    sequence(:email) { |n| "test#{n}@example.com" }
    uid { SecureRandom.alphanumeric(10) }
    password { "password" }
    remember_created_at { nil }
    name { "MyString" }
    tokens { nil }
  end
end