require 'rails_helper'

RSpec.describe Favorite, type: :model do
	let(:user) { FactoryBot.create(:user, name: "sampleuser1", email: "sample1@gmail.com")}
	let(:other_user) { FactoryBot.create(:user, name: "sampleuser2", email: "sample2@gmail.com")}
	let(:other_user_message) { FactoryBot.create(:message, user: other_user)}
	let(:favorite) { FactoryBot.create(:favorite, user: user, message: other_user_message)}
	
  it "is valid with favorite" do
  	expect(favorite).to be_valid
  end
  
  it "is valid with unfavorite" do
  	favorite
  	expect{ favorite.destroy }.to change { Favorite.count }.by(-1)
  end
end
