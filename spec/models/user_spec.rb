require 'rails_helper'

RSpec.describe User, type: :model do

	it "is valid with a name, email, password and password_confirmation" do
		expect(FactoryBot.build(:user)).to be_valid
	end
	
	it "is invalid without a name" do
		user = FactoryBot.build(:user, name: nil)
		user.valid?
		expect(user.errors[:name]).to include("can't be blank")
	end
	
	it "is invalid without an email address" do
		user = FactoryBot.build(:user, email: nil)
		user.valid?
		expect(user.errors[:email]).to include("can't be blank")
	end
	
	it "is invalid with a duplicate email address" do
		FactoryBot.create(:user, email: "sample@gmail.com")
		user = FactoryBot.build(:user, email: "sample@gmail.com")
		user.valid?
		expect(user.errors[:email]).to include("has already been taken")
	end
	
	it "is invalid if the name is too long" do
		user = FactoryBot.build(:user, name: "a" * 51)
		expect(user).to be_invalid
	end
	
	it "is invalid if the email is too long" do
		user = FactoryBot.build(:user, email: "a" * 246 +  "@gmail.com")
		expect(user).to be_invalid
	end
	
	it "is valid if the email address saved as lower-case" do
		user = FactoryBot.build(:user, email: "SaMPle@gmail.com")
		user.save
		expect(user.email).to eq "sample@gmail.com"
	end

end
