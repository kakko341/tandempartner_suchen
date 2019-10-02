require 'rails_helper'

RSpec.describe User, type: :model do

	it "is valid with a first name, last name, email, and password" do
		user = User.new(
			name: "Marius",
			email: "marius@gmail.com",
			password: "marius",
			password_confirmation: "marius"
		)
		expect(user).to be_valid
	end
	
	it "is invalid without a name" do
		user = User.new(name: nil)
		user.valid?
		expect(user.errors[:name]).to include("can't be blank")
	end
	
	# メールアドレスがなければ無効な状態であること
	it "is invalid without an email address"
	# 重複したメールアドレスなら無効な状態であること
	it "is invalid with a duplicate email address"
	# ユーザーのフルネームを文字列として返すこと
	it "returns a user's full name as a string"
end
