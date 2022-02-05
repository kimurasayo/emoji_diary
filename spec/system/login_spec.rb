require 'rails_helper'

RSpec.describe "Login", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン機能' do
    describe 'ログイン' do
      context '認証情報が正しい場合' do
        it '正常にログインできる' do
          visit login_path
          fill_in 'email', with: user.email
          fill_in 'password', with: 'password'
          click_button 'login'
          expect(current_path).to eq user_diaries_path(user)
          expect(page).to have_content "ログインしました。おかえりなさい"
        end
      end

      context '認証情報に誤りがある場合' do
        it 'パスワードを間違えてログインできない' do
          visit login_path
          fill_in 'email', with: user.email
          fill_in 'password', with: '12345678'
          click_button 'login'
          expect(current_path).to eq login_path
          expect(page).to have_content "ログインに失敗しました。"
        end
      end

      it '新規登録ページへ遷移する' do
        visit root_path
        click_link 'login'
        click_link 'make a new account'
        expect(current_path).to eq new_user_path
      end
    end

    describe 'ログアウト' do
      it '正常にログアウトができる' do
        Login_as(user)
        visit root_path
        click_link 'logout'
        find(".commit").click
        expect(current_path).to eq root_path
        expect(page).to have_content "ログアウトしました"
      end
    end
  end
end
