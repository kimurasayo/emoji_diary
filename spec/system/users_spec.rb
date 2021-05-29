require 'rails_helper'

RSpec.describe "Users", type: :system do
  
  describe 'ユーザー新規登録機能' do
    it '新規登録ができる' do
      visit root_path
      click_link 'register'
      fill_in 'nickname', with: 'name'
      fill_in 'user name', with: 'name_1'
      fill_in 'password', with: 'password'
      fill_in 'password confirmation', with: 'password'
      click_button 'register'
      expect(current_path).to eq login_path
      expect(page).to have_content "success🎉 welcome to emory"
    end

    it '新規登録ができない' do
      visit root_path
      click_link 'register'
      fill_in 'nickname', with: 'name'
      fill_in 'user name', with: nil
      fill_in 'password', with: 'password'
      fill_in 'password confirmation', with: 'password'
      click_button 'register'
      expect(current_path).to eq users_path
      expect(page).to have_content "something happened in your information🔗 please check it again"
    end
  end
end
