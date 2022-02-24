require 'rails_helper'

RSpec.describe "Follows", type: :system do
  let(:user) { create(:user) }
  let(:friend) { create(:user, :friend) }
  before { Login_as(user) }

  describe 'フォロー機能' do
    it 'フォローボタンを押してフォローする' do
      visit user_diaries_path(user_name: friend.name)
      click_on "follow"
      expect(current_path).to eq user_diaries_path(user_name: friend.name)
      expect(page).to have_content 'unfollow'
    end

    it 'アンフォローボタンを押してフォローを外す' do
      visit user_diaries_path(user_name: friend.name)
      click_on "follow"
      click_on "unfollow"
      expect(current_path).to eq user_diaries_path(user_name: friend.name)
      expect(page).to have_content 'follow'
    end
  end
end
