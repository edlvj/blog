RSpec.describe User, type: :model do
  subject { create :user }

  context 'association' do
    it { should have_many :posts }
    it { should have_many :comments }
    it { should have_many :ratings }
  end 
end