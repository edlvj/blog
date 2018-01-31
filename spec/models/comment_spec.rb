RSpec.describe Comment, type: :model do
  subject { create :comment }
  
  context 'association' do
    it { should belong_to :user }
    it { should belong_to :post }
  end    

  context 'validation' do
    it { should validate_presence_of(:body) }
  end 
end
