require 'rails_helper'

RSpec.describe "Bookmarks", type: :system do
  let(:user) { create(:user) }
  let(:diary) { create(:diary, user: user) }
  before do
    Login_as(user)
    diary
  end

  describe 'ブックマーク機能' do
    it 'ブックマークする' do
      visit user_diary_path(user_name: user.name, id: diary.id)
      find('a.like-btn').click
      expect(page).to have_selector 'a.unlike-btn'
    end

    it 'ブックマークを外す' do
      visit user_diary_path(user_name: user.name, id: diary.id)
      find('a.like-btn').click
      expect(page).to have_selector 'a.unlike-btn'
      find('a.unlike-btn').click
      expect(page).to have_selector 'a.like-btn'
    end
  end
end
