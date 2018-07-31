require 'rails_helper'

describe "scenario - visit page, create problem, destroy problem, edit problem, add comment, destroy comment, search for problem", type: :feature do

  let!(:user_sud) { create(:user, email: 'user@example.com', password: 'password', is_admin: true) }
  let!(:problem) {create(:problem,title: 'Zaraz przyjdzie wiosna', content: 'Będzie za momencik', reference_list: 'google.com wiosna', creator_id: user_sud.id, status: true)}

  before :each do
    user_sud.confirm
    visit '/users/sign_in'
    within(".new_user") do
      fill_in 'Email', with: user_sud.email
      fill_in 'Password', with: user_sud.password
    end
    click_button 'Log in'
  end

  it "visits main page - create problem form" do
    visit '/problems/new'
    page.should have_content("Title")
    page.should have_field("problem_title")
    page.should have_content("Content")
    page.should have_field("problem_content")
    page.should have_content("Reference list")
    page.should have_field("problem_reference_list")
    page.should have_unchecked_field('Make my post visible to other users')
    page.should have_selector(:link_or_button, 'Save')

  end

  it "creating problem" do
    visit '/problems/new'
    fill_in 'problem_title', with: 'Zaraz przyjdzie wiosna'
    fill_in 'problem_content', with: 'Będzie za momencik'
    fill_in 'problem_reference_list', with: 'google.com wiosna'
    check 'Make my post visible to other users'
    click_link_or_button 'Save'
    expect(page).to have_text('You created post successfully!')
    visit problem_path(Problem.last)
  end

  it "creating comment" do
    visit problem_path(Problem.last)
    page.should have_field("comment_title")
    page.should have_field("comment_content")
    page.should have_field("comment_reference_list")
    fill_in 'comment_title', with: 'Wiosna już dorosła'
    fill_in 'comment_content', with: 'naboje ma w kieszeniach'
    fill_in 'comment_reference_list', with: 'google.com/wiosna'
    click_link_or_button 'Create Comment'
    page.should have_content('Wiosna już dorosła')
    page.should have_content('naboje ma w kieszeniach')
    page.should have_content('google.com/wiosna')
  end

  it "deleting comment " do
    visit problem_path(Problem.last)
    click_link_or_button 'Delete'
    page.driver.browser.switch_to.alert.accept
    page.should have_no_content('Wiosna już dorosła')
    page.should have_no_content('naboje ma w kieszeniach')
    page.should have_no_content('google.com/wiosna')
  end

  it "editing problem " do
    visit problem_path(Problem.last)
    click_link_or_button 'Edit my problem'
    fill_in 'problem_title', with: 'Wiosna wiosna'
    fill_in 'problem_content', with: 'wiosna, ach to ty'
    fill_in 'problem_reference_list', with: 'google.com lato'
    click_link_or_button 'Save'
    click_link_or_button 'Show more information'
    page.should have_content('Wiosna wiosna')
    page.should have_content('wiosna, ach to ty')
    page.should have_content("lato")
  end

  it "deleting problem " do
    visit problem_path(Problem.last)
    click_link_or_button 'Delete my problem'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text('Your problem was successfully destroyed!')
  end

  context 'searching engine' do
    it 'using basic searching engine, see results, see one result' do
      # laziness
      problem_a
      problem_b
      problem_c
      visit root_path
      page.fill_in 'lookup', with: 'Android'
      within 'form' do
        find('.searching-btn').click
      end
      expect(page).to have_current_path(problem_search_path, ignore_query: true)
    end

    it 'using advanced searching' do

    end
  end
end
