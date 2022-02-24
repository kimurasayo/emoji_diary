require 'rails_helper'

RSpec.describe "UserSearches", type: :system do
  let(:user) { create(:user) }
  let(:friend) { create(:user, :friend) }
  before { Login_as(user) }

  describe '友達の日記一覧ページ' do
    it '友達の日記一覧ページを表示できる' do
      visit root_path
      click_on "friend's diary"
      expect(current_path).to eq user_followers_path(user_name: user.name)
    end
  end

  describe '友達検索ページ' do
    it '友達検索ページを表示できる' do
      visit root_path
      click_on "search"
      expect(current_path).to eq users_path
      expect(page).to have_content 'ユーザー名を入力して検索します。'
    end

    it '友達検索ページで友達検索ができる' do
      visit users_path
      find(".user_search").set("friend")
      fill_in 'q_name_cont', with: 'friend'
      click_button 'search'
      expect(current_path).to eq  search_path
      expect(page).to have_content 'friend'
    end
  end
end
