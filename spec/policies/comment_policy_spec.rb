describe CommentPolicy do
  subject { described_class }
  let(:user) { build :user }

  permissions :destroy? do
    context 'denies access' do
      let(:comment) { build :comment }

      it "if it's not user comment" do
        expect(subject).not_to permit(user, comment)
      end
    end

    context 'grants access' do
      let(:comment) { build :comment, user: user }
      it "if it's user comment" do
        expect(subject).to permit(user, comment)
      end
    end  
  end

  permissions :create? do
    context 'denies access' do
      let(:comment) { build :comment }

      it "if it's not user comment" do
        expect(subject).not_to permit([], comment)
      end
    end

    context 'grants access' do
      let(:comment) { build :comment, user: user }
      it "if it's user comment" do
        expect(subject).to permit(user, comment)
      end
    end 
  end
end