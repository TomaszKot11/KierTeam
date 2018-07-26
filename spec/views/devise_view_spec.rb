require 'rails_helper'

describe "the signin process", type: :feature do
  let!(:user_sud) { create(:user, email: 'user@example.com', password: 'password') }
  before :each do
    user_sud.confirm
  end

  it "signs me in" do
    visit '/users/sign_in'
    within(".new_user") do
      fill_in 'Email', with: user_sud.email
      fill_in 'Password', with: user_sud.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end
end