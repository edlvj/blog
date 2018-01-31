RSpec.describe Rating, type: :model do
  subject { create :rating }
  
  context 'association' do
    it { should belong_to :user }
    it { should belong_to :post }
  end    

  context 'validation' do
    it { should validate_presence_of(:score) }
    it { should validate_numericality_of(:score).is_greater_than(0) }
    it { should validate_numericality_of(:score).is_less_than(5) }
  end  
end
