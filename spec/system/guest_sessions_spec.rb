require 'rails_helper'

RSpec.describe "GuestSessions", type: :system do
  describe 'ゲストログイン機能' do
    context '認証情報が正しい場合' do
      it '正常にゲストログインできる' do
        visit root_path
        click_button 'guest login'
        expect(current_path).to eq user_diaries_path(user_name: 'guest')
        expect(page).to have_content "ゲストユーザーでログインしました"
      end
    end
  end

  describe 'ゲストログイン後' do
    it '詳細ページにアクセスできる' do
      visit root_path
      click_button 'guest login'
      click_link '🥳'
      expect(page).to have_content "🥳🙌🎉🎈"
      expect(page).to have_content "🔰"
    end

    it '日記の編集はできない' do
      visit root_path
      click_button 'guest login'
      click_link '🥳'
      click_button 'edit'
      click_button 'save'
      expect(page).to have_content "『ゲスト』は日記を更新できません"
    end

    it '日記の削除はできない' do
      visit root_path
      click_button 'guest login'
      click_link '🥳'
      click_button 'delete'
      find(".commit").click
      expect(current_path).to eq user_diaries_path(user_name: 'guest')
      expect(page).to have_content "『ゲスト』は日記を削除できません"
    end

    it '日記の新規作成はできない' do
      visit root_path
      click_button 'guest login'
      click_on 'write diary'
      click_button 'save'
      expect(current_path).to eq user_diaries_path(user_name: 'guest')
      expect(page).to have_content "『ゲスト』は日記を作成できません"
    end

    it '友達の日記一覧を表示できる' do
      visit root_path
      click_button 'guest login'
      click_link "friend's diary"
      expect(current_path).to eq user_followers_path(user_name: 'guest')
      expect(page).to have_content "🍑 guest2"
    end

    it '友達のページを表示できる' do
      visit root_path
      click_button 'guest login'
      click_link "friend's diary"
      click_link "🍑 guest2", match: :first
      expect(current_path).to eq user_diaries_path(user_name: 'guest2')
    end

    it '友達の検索の検索をすることはできない' do
      visit root_path
      click_button 'guest login'
      click_link "search"
      expect(current_path).to eq user_diaries_path(user_name: 'guest')
      expect(page).to have_content "『ゲスト』はユーザー検索できません"
    end

    it 'プロフィール編集はできない' do
      visit root_path
      click_button 'guest login'
      click_link "🔰guest"
      click_on "edit"
      expect(current_path).to eq profiles_path
      expect(page).to have_content "『ゲスト』はプロフィールを編集できません"
    end

    it '退会できない' do
      visit root_path
      click_button 'guest login'
      click_link "🔰guest"
      click_link "退会"
      find(".commit").click
      expect(current_path).to eq profiles_path
      expect(page).to have_content "『ゲスト』は退会できません"
    end

    it 'ログアウトできる' do
      visit root_path
      click_button 'guest login'
      click_link 'logout'
      find(".commit").click
      expect(current_path).to eq root_path
      expect(page).to have_content "ログアウトしました"
    end
  end
end

