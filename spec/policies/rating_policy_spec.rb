describe RatingPolicy do
  subject { described_class }
  let(:user) { build :user }

  permissions :create? do
    context 'denies access' do
      let(:rating) { build :rating }

      it "if it's not user rating" do
        expect(subject).not_to permit([], rating)
      end
    end

    context 'grants access' do
      let(:rating) { build :rating, user: user }
      it "if it's user rating" do
        expect(subject).to permit(user, rating)
      end
    end 
  end
end