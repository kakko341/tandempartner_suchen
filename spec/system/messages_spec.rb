require 'rails_helper'

RSpec.describe "Messages", type: :system do
	
	let!(:user) { FactoryBot.create(:user, name: "user1") }
  let!(:other_user) { FactoryBot.create(:user, name: "user2") }
  let!(:user_message) { FactoryBot.create(:message, user: user) }
  let!(:other_user_message) { FactoryBot.create(:message, user: other_user) }
  
   describe "As a login user" do
    before do
      sign_in_as user
    end
    context "new post" do
      before do
        visit new_message_path
      end
      it "can post a new message" do
        fill_in "Title", with: "sample"
        fill_in "Post", with: "sample"
        click_button "Save"
        expect(page).to have_content "Succeeded the post!"
        expect(page).to have_content "sample"
      end
    end
    context "edit the post" do
      it "may edit the post" do
        visit edit_message_path(user_message)
        fill_in "Title", with: "sample2"
        fill_in "Post", with: "sample2"
        click_button "Save"
        expect(page).to have_content "Updated the post!"
        expect(page).to have_content "sample2"
      end
    end
    context "Post" do
      it "shows the post" do
        visit message_path(user_message)
        expect(page).to have_content "sample"
      end
      it "can reply" do
        visit new_message_comment_path(user_message)
        fill_in "textarea1", with: "sample comment"
        click_button "Reply"
        expect(page).to have_content "Replied!"
      end
    end
    context "Search engine" do
      it "can search in the post feed" do
        fill_in "Search messages", with: "sample"
        click_button "Search"
        expect(page).to have_content "sample"
      end
    end
  end
end
