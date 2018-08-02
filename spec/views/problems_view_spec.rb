require 'rails_helper'

describe "scenario - visit page, create problem, destroy problem, edit problem, add comment, destroy comment", type: :feature do

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
end

describe "search engine", type: :feature do
  let!(:user1) { create(:user, email: 'user1@example.com', password: 'password') }
  let!(:user2) { create(:user, email: 'user2@example.com', password: 'password') }

  let!(:problem1) {create(:problem, title:'Android not connecting with firebase', content:'In the android configuration, there need to be a line: https-status:true', creator_id: user1.id, status: true)}
  let!(:problem2) {create(:problem, title:'Spring - mysql not working properly', content:'file mysql.lock must be in the properties directory, lorem ipsum', creator_id: user1.id, status: true)}
  let!(:problem3) {create(:problem, title:'C++ SDL not loading music during game running', content:'Additional library is needed, lorem ipsum', creator_id: user2.id, status: true)}

  let!(:tag1) {create(:tag, name:"Android")}
  let!(:tag2) {create(:tag, name:"Java")}
  let!(:tag3) {create(:tag, name:"Database")}
  let!(:tag4) {create(:tag, name:"C++")}

  let!(:problem1_tag1) { create(:problem_tag, problem_id: problem1.id, tag_id: tag1.id)}
  let!(:problem1_tag2) { create(:problem_tag, problem_id: problem1.id, tag_id: tag2.id)}
  let!(:problem1_tag3) { create(:problem_tag, problem_id: problem1.id, tag_id: tag3.id)}

  let!(:problem2_tag1) { create(:problem_tag, problem_id: problem2.id, tag_id: tag2.id)}
  let!(:problem2_tag2) { create(:problem_tag, problem_id: problem2.id, tag_id: tag3.id)}

  let!(:problem3_tag1) { create(:problem_tag, problem_id: problem3.id, tag_id: tag3.id)}
  let!(:problem3_tag2) { create(:problem_tag, problem_id: problem3.id, tag_id: tag4.id)}

  context 'Guest - basic search' do
    before :each do
      visit root_path
    end

    it 'Guest can use basic search engine - case 1' do
      page.fill_in 'lookup', with: problem1.title
      click_link_or_button 'Search'
      page.should have_content(problem1.title)
      page.should have_no_content(problem2.title)
      page.should have_no_content(problem3.title)
    end

    it 'Guest can use basic search engine - case 2' do
      page.fill_in 'lookup', with: problem2.title
      click_link_or_button 'Search'
      page.should have_no_content(problem1.title)
      page.should have_content(problem2.title)
      page.should have_no_content(problem3.title)
    end
  end

  context 'User - basic search' do
    before :each do
      user1.confirm
      visit '/users/sign_in'
      within(".new_user") do
        fill_in 'Email', with: user1.email
        fill_in 'Password', with: user1.password
      end
      click_button 'Log in'
      visit root_path
    end

    it 'User can use basic search engine - case 1' do
      page.fill_in 'lookup', with: problem3.title
      click_link_or_button 'Search'
      page.should have_no_content(problem1.title)
      page.should have_no_content(problem2.title)
      page.should have_content(problem3.title)
    end

    it 'User can use basic search engine - case 2' do
      page.fill_in 'lookup', with: 'asdggsd'
      click_link_or_button 'Search'
      page.should have_no_content(problem1.title)
      page.should have_no_content(problem2.title)
      page.should have_no_content(problem3.title)
    end
  end

  context 'Guest - advanced search' do
    before :each do
      visit root_path
    end

    it 'Guest can use advanced search - by title' do
      click_link_or_button 'Advanced searching'
      find("#title_on").set(true)
      page.fill_in 'lookup', with: 'android'
      click_link_or_button 'Search'
      page.should have_content(problem1.title)
      page.should have_no_content(problem2.title)
      page.should have_no_content(problem3.title)
    end

    it 'Guest can use advanced search - by content' do
      click_link_or_button 'Advanced searching'
      find("#content_on").set(true)
      page.fill_in 'lookup', with: 'lorem ipsum'
      click_link_or_button 'Search'
      page.should have_no_content(problem1.title)
      page.should have_content(problem2.title)
      page.should have_content(problem3.title)
    end
  end

end
