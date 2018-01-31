feature 'Posts List', type: :feature do
  before do
    create_list(:post, 10, :with_ratings) 
    visit root_path
  end
  
  context 'Show Catalog List' do
    scenario 'contains 10 elements on page' do
      expect(page).to have_selector('h1#post', count: 10)
    end
    
    scenario 'books have links' do
      (1..10).each do |id|
        expect(page).to have_link('Read')
      end
    end 
  end

  context 'Filter Catalog List' do
    scenario 'contains all on page' do
      fill_filter_form(1)
      expect(page).to have_selector('h1#post', count: 10)
    end

    scenario 'not contains on page' do
      fill_filter_form(5)
      expect(page).to have_content('No posts')
    end
  end

  def fill_filter_form(value)
    within "#filter_avg" do
      fill_in 'avg_score', with: value
      first('.btn', 'Filter').click
    end  
  end 
end