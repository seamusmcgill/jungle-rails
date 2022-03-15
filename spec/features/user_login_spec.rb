require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  # SETUP 
  before :each do
    @user = User.create!(name: 'Joe Blow', email: 'joeblow@gmail.com', password: 'password', password_confirmation: 'password')
  end

  scenario "They go to the correct product page" do
    #ACT
    visit '/login'

    fill_in 'email', with: 'joeblow@gmail.com'
    fill_in 'password', with: 'password'
    click_on 'Log In'

    expect(page).to have_content("Products")

    save_screenshot
  end 
end
