require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "creation" do
    before do
      @user = create(:user)
      login_as @user, :scope => :user
      @post = create(:post, user_id: @user.id)
    end

    it "can be created" do
      expect(@post).to be_valid
    end

    it "cannot be created without a date and rationale" do
      @post.date = nil
      @post.rationale = nil
      expect(@post).to be_invalid
    end

  end
end
