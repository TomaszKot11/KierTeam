require 'rails_helper'

describe "scenaria - visit page, create tag, destroy tag, edit tag", type: :feature do

  let!(:user_sud) { create(:user, email: 'user@example.com', password: 'password', is_admin: true) }
  let!(:tag1) {create(:tag, name: "Android")}

  before :each do
    user_sud.confirm
    visit '/users/sign_in'
    within(".new_user") do
      fill_in 'Email', with: user_sud.email
      fill_in 'Password', with: user_sud.password
    end
    click_button 'Log in'
  end

  it "visits main page - has create tag form" do
    visit '/tags'
    page.should have_content("Create a tag")
    page.should have_field("tag_name")
    page.should have_selector(:link_or_button, 'Submit')
    page.should have_content("Android")
    page.should have_selector(:link_or_button, 'Delete')
    page.should have_selector(:link_or_button, 'Edit')
  end

  it "create tag - the record is appended" do
    visit '/tags'
    fill_in 'tag_name', with: 'Ruby on Rails'
    click_link_or_button 'Submit'
    page.should have_content('Ruby on Rails')
  end

  it "delete tag - the record is removed" do
    visit '/tags'
    click_link_or_button 'Delete'
    page.driver.browser.switch_to.alert.accept
    page.should have_no_content("Android")
  end

  it "edit tag - the record is changed" do
    visit '/tags'
    click_link_or_button 'Edit'
    page.should have_content("Edit a tag")
    page.should have_field("tag_name")
    fill_in "tag_name", with: 'Android_changed'
    click_link_or_button 'Submit'
    page.should have_content("Android_changed")
  end
end