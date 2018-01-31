RSpec.describe CommentsController, type: :controller do
  subject { create :comment }

  before :each do
    sign_in subject.user, scope: :user
  end

  describe 'POST #create' do
    let(:params) { { comment: attributes_for(:comment), post_id: subject.post.id } }
    before { post :create, params: params }

    it 'flash notice' do
      expect(flash[:notice]).to eq "Comment created"
    end

    it 'redirect to post' do
      expect(response).to redirect_to assigns(:post)
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: { id: subject.id, post_id: subject.post.id }
    end
    
    it 'flash notice' do
      expect(flash[:notice]).to eq "Comment deleted"
    end

    it 'redirect to post' do
      expect(response).to redirect_to assigns(:post)
    end
  end
end
