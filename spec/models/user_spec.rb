require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
  end
  describe "creation" do
    it "can be created" do
      expect(@user).to be_valid
    end
    it "can not be created without first name and last name" do
      @user.first_name = nil
      @user.last_name = nil
      expect(@user).to be_invalid
    end
  end

  describe "custom name methods" do
    it "has a full_name method that combines first and last name" do
      expect(@user.full_name).to eq("#{@user.last_name.upcase}, #{@user.first_name.upcase}")
    end
  end
end
