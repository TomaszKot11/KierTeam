require 'rails_helper'

describe "devise views - login, register, ", type: :feature do
  let!(:user1) { create(:user, email: 'user@example.com', password: 'password') }
  before :each do
    user1.confirm
  end

  it "login with valid attributes" do
    visit '/users/sign_in'
    within(".new_user") do
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end

  it "login with invalid attributes" do
    visit '/users/sign_in'
    within(".new_user") do
      fill_in 'Email', with: ''
      fill_in 'Password', with: user1.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password'
  end


  it "sign up with valid attributes" do
    visit '/users/sign_up'
    within(".new_user") do
      fill_in 'Name', with: user1.name
      fill_in 'Surname', with: user1.surname
      fill_in 'Position', with: user1.position
      fill_in 'Email', with: "user1.email@aa.pl"
      fill_in 'Password', with: user1.password
      fill_in 'Password confirmation', with: user1.password
    end
    click_button 'Sign up'
    expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
  end

  it "sign up with invalid attributes" do
    visit '/users/sign_up'
    within(".new_user") do
      # fill nothing
    end
    click_button 'Sign up'
    expect(page).to have_content '8 errors prohibited this user from being saved:'
  end

  it "remind password with valid attributes" do
    visit '/users/password/new'
    within(".new_user") do
      fill_in 'Email', with: user1.email
    end
    click_button 'Send me reset password instructions'
     expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
  end

  it "remind password with invalid attributes" do
    visit '/users/password/new'
    within(".new_user") do
      # fill nothing
    end
    click_button 'Send me reset password instructions'
    expect(page).to have_content "Email can't be blank"
  end
end