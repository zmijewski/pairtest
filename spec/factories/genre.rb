FactoryBot.define do
  factory :genre do
    name { Faker::Lorem.word }

    trait :with_movies do
      after(:create) do |genre|
        create_list :movie, 5, genre: genre
      end
    end

    trait :with_movie do
      after(:create) do |genre|
        create_list :movie, 1, genre: genre
      end
    end
  end
end
