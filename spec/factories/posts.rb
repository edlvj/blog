FactoryBot.define do
  factory :post do
    title FFaker::Book.title
    text FFaker::Book.description
    user { create(:user) }
  
    trait :with_ratings do
      after(:create) do |instance|
        create_list :rating, 1, post: instance
      end
    end

    trait :invalid do
      title ''
      text 'fd'
    end  
  end

end