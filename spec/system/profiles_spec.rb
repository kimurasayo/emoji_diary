require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  let(:user) { create(:user) }
  before { Login_as(user) }

  describe 'プロフィールページ' do
    it 'プロフィールページを表示できる' do
      visit profiles_path
      expect(current_path).to eq profiles_path
      expect(page).to have_content user.name
    end

    it 'プロフィールを編集できる' do
      visit profiles_path
      click_on "edit"
      fill_in 'user name', with: 'newname'
      click_on "update"
      expect(current_path).to eq profiles_path
      expect(page).to have_content '『newname』のプロフィールを更新しました'
      expect(page).to have_content 'newname'
    end
  end

  describe '退会処理' do
    it '退会することができる' do
      visit profiles_path
      click_on "退会"
      find(".commit").click
      expect(current_path).to eq root_path
      expect(page).to have_content '退会しました。ご利用ありがとうございました！'
    end
  end
end
