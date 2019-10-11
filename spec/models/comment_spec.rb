require 'rails_helper'

RSpec.describe Comment, type: :model do
	
  it "is a valid comment with a content" do
  	expect(FactoryBot.create(:comment)).to be_valid
	end
	
	it "is invalid if the content is too long" do
		comment = FactoryBot.build(:comment, content: "a" * 256)
		expect(comment).to be_invalid
	end
end
