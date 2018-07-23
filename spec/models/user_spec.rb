require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'Validations' do

    before (:each) do
      @password = BCrypt::Password.create("BigMan")
      @user = User.new(firstname: "Big", lastname: "Boi", email: "bigboi@bigman.com", password_digest:@password )
    end

    it "should not save if email is not unique" do
      @user.save
      @user2 = User.new(firstname: "Copy", lastname: "Boi", email: "bigboi@bigman.com", password_digest:@password )
      @user2.valid?
      expect(@user2.errors.to_a).to eql(["Email has already been taken"])
    end

    it "should have a firstname" do
      expect(@user.firstname).to be_present
    end

    it "should have a lastname" do
      expect(@user.lastname).to be_present
    end

    it "should have an email" do
      expect(@user.email).to be_present
    end

    it "should have a password_digest" do
      expect(@user.password_digest).to be_present
    end

    it "should fail if password is less than 6 letters" do
      @password = "123"
      @user.password_digest = @password
      @user.valid?
      expect(@user.errors.to_a).to eql(["Password digest is too short (minimum is 6 characters)"])
    end
  end

  describe '.authenticate_with_credentials' do

    before (:each) do
      @password = BCrypt::Password.create("BigMan")
      @user = User.new(firstname: "Big", lastname: "Boi", email: "bigboi@bigman.com", password_digest:@password )
      @user.save!
    end

    it "should return nothing if email can't be matched" do
      expect(User.authenticate_with_credentials("bigboi2222@bigman.com", "BigMan")).to be nil
    end

    it "should return nothing if password can't be matched" do
      expect(User.authenticate_with_credentials("bigboi@bigman.com", "Big33Man")).to be false
    end

    it "should return the user even if email has spaces" do
      expect(User.authenticate_with_credentials(" bigboi@bigman.com", "BigMan")).to be_truthy
    end

    it "should return the user even if email has different cases" do
      expect(User.authenticate_with_credentials("biGBoI@biGMan.cOM", "BigMan")).to be_truthy
    end

  end

end
