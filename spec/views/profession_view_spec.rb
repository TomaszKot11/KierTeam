require 'rails_helper'

describe "scenario - visit page, create profession, destroy profession, edit profession", type: :feature do

  let!(:user_sud) { create(:user, email: 'user@example.com', password: 'password', is_admin: true, profession_id:nil) }
  let!(:profession1) {create(:profession, name: "Android developer")}

  before :each do
    user_sud.confirm
    visit '/users/sign_in'
    within(".new_user") do
      fill_in 'Email', with: user_sud.email
      fill_in 'Password', with: user_sud.password
    end
    click_button 'Log in'
  end

  it "visits main page - has create profession form" do
    visit '/professions'
    page.should have_content("Create a profession")
    page.should have_field("profession_name")
    page.should have_selector(:link_or_button, 'Submit')
    page.should have_content("Android developer")
    page.should have_selector(:link_or_button, 'Delete')
    page.should have_selector(:link_or_button, 'Edit')
  end

  it "create profession - the record is appended" do
    visit '/professions'
    fill_in 'profession_name', with: 'Ruby on Rails developer'
    click_link_or_button 'Submit'
    page.should have_content('Ruby on Rails developer')
  end

  it "delete profession - the record is removed" do
    visit '/professions'
    click_link_or_button 'Delete'
    page.driver.browser.switch_to.alert.accept
    page.should have_no_content("Android developer")
  end

end