require 'rails_helper'

RSpec.describe "Relationships", type: :system do
	
  let!(:user) { FactoryBot.create(:user, name: "user1") }
  let!(:other_user) { FactoryBot.create(:user, name: "user2") }

  let(:active_relationship) do
    user.relationships.create(
      user_id: user.id, follow_id: other_user.id
    )
  end
  let(:passive_relationship) do
    user.reverses_of_relationship.create(
      user_id: other_user.id, follow_id: user.id
    )
  end

  describe "As a login user" do
    before do
      sign_in_as user
    end
    context "Follow" do
      it "can follow a user in the all users page" do
        visit users_path
        expect do
          click_button "Follow"
          sleep 2
        end.to change(Relationship, :count).by(1)
      end
      it "can unfollow a user in the all users page" do
        active_relationship
        visit users_path
        expect do
          click_button "Unfollow"
          sleep 2
        end.to change(Relationship, :count).by(-1)
      end
      it "can follow at the other user's page" do
        passive_relationship
        visit user_path(other_user)
        expect do
          click_button "Follow"
          sleep 2
        end.to change(Relationship, :count).by(1)
      end
      it "can unfollow at the other user's page" do
        active_relationship
        passive_relationship
        visit user_path(other_user)
        expect do
          click_button "Unfollow"
          sleep 2
        end.to change(Relationship, :count).by(-1)
      end
    end
    context "Counter" do
      before do
        active_relationship
        passive_relationship
      end
      it "shows number of following and follower users" do
        visit user_path(user)
        expect(page).to have_content 'Follow 1'
        expect(page).to have_content 'Follower 1'
      end
    end
    context "No follow/unfollow button on own page" do
      it "doesn't show follow/unfollow button on own page" do
        visit users_path
        expect(page).to_not have_content 'Follow', 'Unfollow'
      end
    end
  end
end
