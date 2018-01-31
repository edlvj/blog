feature 'Show post', type: :feature do
  subject { create :post }

  context 'have post attributes' do
    before { visit post_path(subject) }

    scenario 'contains title and text' do
      expect(page).to have_content(subject.title)
      expect(page).to have_content(subject.text)
    end  
  end

  context 'when user not logged' do
    before { visit post_path(subject) }
    
    scenario 'not actions buttons' do
      within '#post_actions' do
        expect(page).to_not have_link "Edit"
      end
    end  
  end

  context 'when user logged' do
    background do
      login_as(subject.user, scope: :user)
      visit post_path(subject)
    end

    scenario 'contain actions buttons' do
      within '#post_actions' do
        expect(page).to have_link "Edit"
      end
    end  
  end

  context 'when it is not user post' do
    let(:user) { create :user }

    background do
      login_as(user, scope: :user)
      visit post_path(subject)
    end

    scenario 'not contain action buttons' do
      within '#post_actions' do
        expect(page).to_not have_link "Edit"
      end
    end  
  end
end