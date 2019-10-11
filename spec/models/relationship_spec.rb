require 'rails_helper'

RSpec.describe Relationship, type: :model do
	
	let(:user) { FactoryBot.create(:user, name: "sampleuser1", email: "sample1@gmail.com")}
	let(:other_user) { FactoryBot.create(:user, name: "sampleuser2", email: "sample2@gmail.com")}
  
  context 'relationship' do
  	
  	it "is valid if it is following" do
  		relationship = Relationship.new(
  			user_id: user.id,
  			follow_id: other_user.id
  		)
  		expect(relationship).to be_valid
  	end
  	
  	it "is valid if it is followed" do
  		relationship = Relationship.new(
  			user_id: other_user.id,
  			follow_id: user.id
  		)
  		expect(relationship).to be_valid
  	end
  	
  	it "is invalid if it is not following" do
  		relationship = Relationship.new(
  			user_id: user.id,
  			follow_id: nil
  		)
  		expect(relationship).to_not be_valid
  	end
  	
  	it "is invalid if it is not followed" do
  		relationship = Relationship.new(
  			user_id: nil,
  			follow_id: other_user.id
  		)
  		expect(relationship).to_not be_valid
  	end
  end
end
