
require 'rails_helper'

describe 'navigate' do
  before do
    # @user = User.create(email: "test@test.com", password: "123456", password_confirmation: "123456", first_name: "Jon", last_name: "Snow")
    @user = create(:user)
    login_as @user, :scope => :user
  end
  describe 'index' do
    before do
      visit posts_path
    end
    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      expect(page).to have_content('Posts')
    end

    it 'has a list of posts' do
      # post1 = Post.create(date: Date.today, rationale: "Post1", user_id: @user.id)
      # # post2 = Post.create(date: Date.today, rationale: "Post2", user_id: @user.id)
      create(:post, user_id: @user.id)
      create(:second_post, user_id: @user.id)
      visit posts_path
      expect(page).to have_content(/Some Rationale|Some more content/)
    end
  end

  describe 'creation' do
    before do
      visit new_post_path
    end
    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'post[date]', with: "#{Date.today}"
      fill_in 'post[rationale]', with: 'Some Rationale'

      click_on 'Submit'

      expect(page).to have_content("Rationale")
    end

    it 'will have a user associated with it' do
      fill_in 'post[date]', with: "#{Date.today}"
      fill_in 'post[rationale]', with: 'User Association'

      click_on 'Submit'
      expect(User.last.posts.last.rationale).to eq("User Association")
    end
  end

  describe 'edit' do
    before do
      @post = create(:post, user_id: @user.id)
    end
    it 'can be reached by edit on index page' do

      visit posts_path
      click_link "edit_#{@post.id}"
      expect(page.status_code).to eq(200)
    end

    it 'can be edited' do
      visit edit_post_path(@post)

      fill_in 'post[date]', with: "#{Date.today}"
      fill_in 'post[rationale]', with: 'Edited Content'

      click_on 'Submit'

      expect(page).to have_content('Edited Content')
    end
  end
end