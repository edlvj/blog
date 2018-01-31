RSpec.describe Post, type: :model do
  subject { create :post }

  context 'association' do
    it { should belong_to :user }
    it { should have_many :comments }
    it { should have_many :ratings }
  end    

  context 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:text) }
  end 

  describe '#average_rating' do
    it 'with rating return 3' do
      subject = create :post, :with_rating
      expect(subject.average_rating).to eq(1.0)
    end
    it 'without rating return 0' do
      expect(subject.average_rating).to eq(nil)
    end
  end 
end