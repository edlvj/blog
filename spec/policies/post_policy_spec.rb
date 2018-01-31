describe PostPolicy do
  subject { described_class }
  let(:user) { build :user }

  permissions :update?, :edit?, :destroy? do
    context 'denies access' do
      let(:post) { build :post }

      it "if it's not user post" do
        expect(subject).not_to permit(user, post)
      end
    end

    context 'grants access' do
      let(:post) { build :post, user: user }
      it "if it's user post" do
        expect(subject).to permit(user, post)
      end
    end  
  end

  permissions :create?, :new? do
    context 'denies access' do
      let(:post) { build :post }

      it "if it's not user post" do
        expect(subject).not_to permit([], post)
      end
    end

    context 'grants access' do
      let(:post) { build :post, user: user }
      it "if it's user post" do
        expect(subject).to permit(user, post)
      end
    end 
  end

end