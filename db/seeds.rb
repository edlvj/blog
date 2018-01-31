
POSTS_AMOUNT = 3

user = User.create! email: FFaker::Internet.free_email,
                  password: 'password',
                  password_confirmation: 'password'


POSTS_AMOUNT.times do
  Post.find_or_create_by! title: FFaker::Name.name,
                          text: FFaker::Name.name,
                          user: user
end


Post.find_each do |post|
  Comment.find_or_create_by! body: FFaker::CheesyLingo.title,
                             post: post,
                             user: user

  Rating.find_or_create_by! post: post,
                            user: user,
                            score: 3
end