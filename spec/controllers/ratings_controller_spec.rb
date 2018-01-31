RSpec.describe RatingsController, type: :controller do
  subject { create :rating }

  before :each do
    sign_in subject.user, scope: :user
  end

  describe 'POST #create' do
    let(:params) { { score: 3, post_id: subject.post.id } }
    it 'create resourse' do
      expect { 
        post :create, params: params, format: :json 
      }.to change(Rating, :count).by(1)
    end
    
    it 'returns http success' do
      post :create, params: params, format: :json
      expect(response).to have_http_status(:success)
    end
  end
end
