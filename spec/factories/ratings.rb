FactoryBot.define do
  factory :rating do
    post { create(:post) }
    user { create(:user) }
    score 1
  end
end
