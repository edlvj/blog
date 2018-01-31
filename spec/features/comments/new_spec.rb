feature 'Comment New', type: :feature do
  subject { create :post }
  
  background do
    login_as(subject.user, scope: :user)
    visit post_path(subject)
  end

  context 'when fill valid data' do
    scenario 'contains notice' do
      fill_comment_form(attributes_for(:comment))
      expect(page).to have_content("Comment created")
    end  
  end

  context 'when fill valid data' do
    scenario 'contains title and text' do
      fill_comment_form(attributes_for(:comment, :invalid))
      expect(page).to have_content("is too short (minimum is 3 characters)")
    end  
  end

  def fill_comment_form(options)
    within '#comment_form' do
      fill_in 'comment[body]', with: options[:body]
      first('.btn', 'Create Comment').click
    end
  end
end