require 'rails_helper'

RSpec.describe "Users", type: :system do

  describe 'ユーザー新規登録機能' do
    it '新規登録ができる' do
      visit root_path
      click_link 'sign up'
      fill_in 'user name', with: 'name1'
      fill_in 'email', with: 'name1@example.com'
      fill_in 'password', with: 'password', match: :first
      fill_in 'password confirmation', with: 'password'
      click_button 'sign up'
      expect(current_path).to eq new_user_diary_path(user_name: 'name1')
      expect(page).to have_content "ご登録ありがとうございます"
    end

    it '新規登録ができない' do
      visit root_path
      click_link 'sign up'
      fill_in 'user name', with: 'name'
      fill_in 'email', with: nil
      fill_in 'password', with: 'password', match: :first
      fill_in 'password confirmation', with: 'password'
      click_button 'sign up'
      expect(current_path).to eq users_path
    end

    it 'ログインページへ遷移する' do
      visit root_path
      click_link 'sign up'
      click_link 'already a member?'
      expect(current_path).to eq login_path
    end
  end
end
