require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "creation" do
    before do
      user = User.create(email: "test@test.com", password: "123456", password_confirmation: "123456", first_name: "Jon", last_name: "Snow")
      login_as user, :scope => :user
      @post = Post.create(date: Date.today, rationale: "anything", user_id: user.id)
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
