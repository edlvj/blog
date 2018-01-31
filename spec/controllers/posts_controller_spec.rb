RSpec.describe PostsController, type: :controller do
  subject { create :post }

  before :each do
    sign_in subject.user, scope: :user
  end
  
  describe 'GET #index' do
    context 'when resource is found' do
      before { get :index }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the :index template' do
        expect(response).to render_template(:index)
      end

      it 'returns all' do
        expect(assigns(:posts)).to eq([subject])
      end
    end

    describe 'with params[:avg_score]' do
      context 'when rating persist' do
        let(:rating) { create :rating, post_id: subject.id }

        it 'returns item' do
          get :index, params: { avg_score: rating.score }
          expect(assigns(:posts)).to eq([subject])
        end
      end

      context 'when rating exist' do
        it 'return []' do
          get :index, params: { avg_score: 3 }
          expect(assigns(:posts)).to eq([])
        end
      end
    end

    describe 'with params[:user_id]' do
      context 'when user persist' do
        it 'returns item' do
          get :index, params: { user_id: subject.user_id }
          expect(assigns(:posts)).to eq([subject])
        end
      end

      context 'when user exist' do
        it 'return []' do
          get :index, params: { user_id: 0 }
          expect(assigns(:posts)).to eq([])
        end
      end
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: subject.id }
    end
    context 'when post found' do
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns post' do
        expect(assigns(:post)).to eq(subject)
      end

      it 'renders the :show template' do
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET #new' do
    let(:post) { double :post }
    before { get :new }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the :new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:params) { { post: attributes_for(:post) } }
    before { post :create, params: params }

    it 'flash notice' do
      expect(flash[:notice]).to eq "Post created"
    end

    it 'redirect to post' do
      expect(response).to redirect_to assigns(:post)
    end
  end
  
  describe 'GET #edit' do
    before do
      get :edit, params: { id: subject.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the :edit template' do
      expect(response).to render_template(:edit)
    end
  end 

  describe 'PATCH #update' do
    let(:params) { { post: attributes_for(:post), id: subject.id } }
    
    before do
      get :update, params: params
    end
    
    it 'flash notice' do
      expect(flash[:notice]).to eq "Post updated"
    end

    it 'redirect to post' do
      expect(response).to redirect_to subject
    end
  end 

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: { id: subject.id }
    end
    
    it 'flash notice' do
      expect(flash[:notice]).to eq "Post deleted"
    end

    it 'redirect to post' do
      expect(response).to redirect_to posts_path
    end
  end
end