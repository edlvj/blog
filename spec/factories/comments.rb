FactoryBot.define do
  factory :comment do
    body FFaker::Book.genre
    post { create(:post) }
    user { create(:user) }
  
  trait :invalid do
    body '1s'
  end  

  end
end
