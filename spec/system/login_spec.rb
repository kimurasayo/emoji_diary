require 'rails_helper'

RSpec.describe "Login", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン機能' do
    describe 'ログイン' do
      context '認証情報が正しい場合' do
        it '正常にログインできる' do
          visit login_path
          fill_in 'user name', with: user.name
          fill_in 'password', with: 'password'
          click_button 'login'
          expect(current_path).to eq diaries_path
          expect(page).to have_content "success🔓 you are logged in now"
        end
      end

      context '認証情報に誤りがある場合' do
        it 'パスワードを間違えてログインできない' do
          visit login_path
          fill_in 'user name', with: user.name
          fill_in 'password', with: '123456'
          click_button 'login'
          expect(current_path).to eq login_path
          expect(page).to have_content "failed🔐 you are not able to login"
        end
      end
    end

    describe 'ログアウト' do

      it '正常にログアウトができる' do
        Login_as(user)
        visit root_path
        click_link 'logout'
        expect(current_path).to eq root_path
        expect(page).to have_content "thank you❤️ please come it again"
      end
    end
  end
end
