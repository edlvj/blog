feature 'Posts List', type: :feature do
  subject { create :post }

  background do
    login_as(subject.user, scope: :user)
    visit new_post_path
  end

  context 'when fill valid data' do
    scenario 'contains notice' do
      fill_post_form(attributes_for(:post))
      expect(page).to have_content("Post created")
    end  
  end

  context 'when fill invalid data' do
    scenario 'contains validation message' do
      fill_post_form(attributes_for(:post, :invalid))
      expect(page).to have_content("is too short (minimum is 3 characters)")
    end  
  end

  def fill_post_form(options)
    within '#post_form' do
      fill_in 'post[title]', with: options[:title]
      fill_in 'post[text]', with: options[:text]
      first('.btn', 'Create Post').click
    end
  end
end