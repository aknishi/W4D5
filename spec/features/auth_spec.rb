require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  background :each do
    visit new_user_url
  end
    scenario 'has a new user page'do
      expect(page).to have_content 'New User'
    end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      visit new_user_url
      fill_in 'Username', with: 'testing_username'    
      fill_in 'Password', with: '123567'
      click_on 'Sign up'
      expect(page).to have_content 'testing_username'
    end
  end
end

feature 'logging in' do
  
  background :each do
    visit new_session_url
    fill_in 'Username', with: 'testing_username'    
    fill_in 'Password', with: '123567'
    click_on 'Log In'
  end
  scenario 'shows username on the homepage after login' do
    expect(page).to have_content 'testing_username'
  end

end

feature 'logging out' do
  
  scenario 'begins with a logged out state' do 
    visit root_url
    expect(page).to have_content 'Log in'
  end
    
  scenario 'doesn\'t show username on the homepage after logout' do
    visit new_session_url
    fill_in 'Username', with: 'testing_username'    
    fill_in 'Password', with: '123567'
    click_on 'Log In'
    click_on 'Log out'
    expect(page).to_not have_content 'testing_username'
  end
  
end