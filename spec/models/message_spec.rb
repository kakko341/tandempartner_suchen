require 'rails_helper'

RSpec.describe Message, type: :model do
	
  it "is a valid message with title and content" do
  	expect(FactoryBot.build(:message)).to be_valid
  end
  
  it "is invalid without a title" do
		message = FactoryBot.build(:message, title: nil)
		message.valid?
		expect(message.errors[:title]).to include("can't be blank")
	end
	
	 it "is invalid without a content" do
		message = FactoryBot.build(:message, content: nil)
		message.valid?
		expect(message.errors[:content]).to include("can't be blank")
	end
  
  
  it "is invalid if the title is too long" do
		message = FactoryBot.build(:message, title: "a" * 256)
		expect(message).to be_invalid
	end
	
  it "is invalid if the title is too long" do
		message = FactoryBot.build(:message, content: "a" * 256)
		expect(message).to be_invalid
	end
end
