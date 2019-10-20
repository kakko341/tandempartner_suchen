require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) do
  	FactoryBot.create(:user,
  										name: "user1",
  										email: "sampleuser1@gmail.com",
  										password: "sample"
  		)
  end
  
  let!(:other_user) do
  	FactoryBot.create(:user,
  										name: "user2",
  										email: "sampleuser2@gmail.com",
  										password: "sample"
  		)
  end
  
  let!(:user_message) { FactoryBot.create(:message, user: user) }
  let!(:other_user_message) { FactoryBot.create(:message, user: other_user) }
  
  context "Sign up" do
  	it "can create a new account" do
  		expect do
  			visit signup_path
  			fill_in "Name", with: "mark"
  			fill_in "E-mail", with: "mark@gmail.com"
  			fill_in "Password", with: "mark"
  			fill_in "Password confirmation", with: "mark"
  			click_button "Save"
  		end.to change { User.count }.by(0)
  	end
  end
  
  context "Log in" do
    it "shows home page after log in" do
      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      expect(page).to have_content 'Succeeded to log in'
      expect(page).to have_content user.name
    end
  end
  
  context "As a Login User" do
    before do
      sign_in_as user
    end
    it "is valid updating the profile" do
      visit edit_user_path(user)
      fill_in "Name", with: user.name
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      fill_in "Confirmation", with: user.password
      click_button "Save changes"
      expect(page).to have_content "Profile updated"
      expect(page).to have_content user.name
    end
    it "shows all users" do
      visit users_path
      expect(page).to have_content user.name
      expect(page).to have_content other_user.name
    end
    it "shows the user's profile" do
      visit user_path(user)
      expect(page).to have_content user.name
    end
    it "shows the other user's profile" do
      visit user_path(other_user)
      expect(page).to have_content other_user.name
    end
  end
  
  context "As a guest user" do
    it "may not show the user's profile" do
      visit user_path(user)
      expect(page).to have_content "Please log in"
    end
    it "may not show the user's profile" do
      visit users_path
      expect(page).to have_content "Please log in"
    end
    it "may not edit the user's profile" do
      visit edit_user_path(user)
      expect(page).to have_content "Please log in"
    end
  end
end
