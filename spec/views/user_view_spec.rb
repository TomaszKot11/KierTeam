require 'rails_helper'

describe "user - visit index", type: :feature do
  let!(:user) { create(:user, email: 'user@example.com', name: 'user_name', surname: 'user_surname', password: 'password', is_admin: false, profession_id: nil) }

  it "user - visits main page - no admin buttons" do
    user.confirm
    visit '/users/sign_in'
    within(".new_user") do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_button 'Log in'
    visit '/users'
    page.should have_content(user.email)
    page.should have_content(user.name)
    page.should have_content(user.surname)
    page.should have_no_selector(:link_or_button, 'Delete')
    page.should have_no_selector(:link_or_button, 'Ban')
  end
end

describe "admin - visit index, edit user, delete user  ", type: :feature do

  let!(:user) { create(:user, email: 'user@example.com', name: 'user_name', surname: 'user_surname', password: 'password', is_admin: false, profession_id: nil) }
  let!(:user_admin) { create(:user, email: 'admin@example.com', password: 'password', is_admin: true, profession_id: nil) }

  before :each do
    user_admin.confirm
    visit '/users/sign_in'
    within(".new_user") do
      fill_in 'Email', with: user_admin.email
      fill_in 'Password', with: user_admin.password
    end
    click_button 'Log in'
    visit '/users'
  end

  it "visits main page" do
    page.should have_content("user@example.com")
    page.should have_content("user_name")
    page.should have_content("user_surname")
    page.should have_selector(:link_or_button, 'Delete')
    page.should have_selector(:link_or_button, 'Ban')
  end

  it "deletes user" do
    click_link_or_button 'Delete'
    page.driver.browser.switch_to.alert.accept
    page.should have_no_content("user@example.com")
    page.should have_no_content("user_name")
    page.should have_no_content("user_surname")
    page.should have_no_selector(:link_or_button, 'Delete')
    page.should have_no_selector(:link_or_button, 'Ban')
  end

  it "ban user" do
    click_link_or_button 'Ban'
    page.driver.browser.switch_to.alert.accept
    page.should have_content("Banned")
  end

  it "unban user" do
    click_link_or_button 'Ban'
    page.driver.browser.switch_to.alert.accept
    click_link_or_button 'Unban'
    page.driver.browser.switch_to.alert.accept
    page.should have_no_content("Banned")
  end
end
