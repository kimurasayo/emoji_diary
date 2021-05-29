require 'rails_helper'

RSpec.describe "Diaries", type: :system do
  describe '日記のCRUD機能' do
    let(:user) { create(:user) }
    let(:diary) { create(:diary, user: user) }
    let(:yesterday_diary) { create(:diary, :yesterday, user: user) }

    describe '日記の一覧画面' do
      context 'ログインしている場合' do
        before do 
          Login_as(user)
          yesterday_diary
        end

        it 'ヘッダーのmineリンクから日記一覧ページにアクセスできる' do
          click_link 'mine'
          expect(current_path).to eq(diaries_path)
        end

        it '投稿済みの昨日の日記がある場合、feelingの顔文字が昨日の日付の欄に記載されている' do
          click_link 'mine'
          expect(current_path).to eq(diaries_path)
          expect(page).to have_content('🥳')
        end
      end

      context 'ログインしていない場合' do
        it '日記一覧ページにアクセスできず、ログインページに遷移する' do
          visit diaries_path
          expect(current_path).to eq(login_path)
        end
      end
    end

    describe '日記の新規投稿画面' do
      context 'ログインしている場合' do
        before { Login_as(user) }

        it 'ヘッダーのnewリンクから日記新規投稿ページにアクセスできる' do
          click_link 'new'
          expect(current_path).to eq(new_diary_path)
        end

        it '日記が作成できる' do
          click_link 'new'
          fill_in 'feeling', with: '🥺'
          click_on 'Create diary'
          expect(current_path).to eq(diaries_path)
          expect(page).to have_content('🥺')
        end

        it '日記が作成できない' do
          click_link 'new'
          click_on 'Create diary'
          expect(page).to have_content('something went wrong')
        end
      end

      context 'ログインしていない場合' do
        it '日記新規投稿ページにアクセスできず、ログインページに遷移する' do
          visit new_diary_path
          expect(current_path).to eq(login_path)
        end
      end
    end

    describe '日記の詳細画面' do
      context 'ログインしている場合' do
        it '日記詳細ページから日記編集ページにアクセスできる' do
          Login_as(user)
          visit diary_path(diary.id)
          click_on "button-edit-#{diary.id}"
          expect(current_path).to eq(edit_diary_path(diary.id))
        end
      end

      context 'ログインしていない場合' do
        it '日記詳細ページにアクセスできず、ログインページに遷移する' do
          visit diary_path(diary)
          expect(current_path).to eq login_path
        end
      end
    end

    describe '日記の編集画面' do
      context 'ログインしている場合' do
        before do 
          Login_as(user)
          visit diary_path(diary.id)
          click_on "button-edit-#{diary.id}"
        end

        it '日記を編集することができる' do
          fill_in 'feeling', with: '😣'
          click_on 'Update diary'
          expect(current_path).to eq diaries_path
          expect(page).to have_content('it has been updated')
          expect(page).to have_content('😣')
        end

        it '日記を編集することができない' do
          fill_in 'feeling', with: ''
          click_on 'Update diary'
          expect(page).to have_content("can't be blank")
        end
      end

      context 'ログインしていない場合' do
        it '日記編集ページにアクセスできず、ログインページに遷移する' do
          visit edit_diary_path(diary)
          expect(current_path).to eq login_path
        end
      end
    end

    describe '日記の削除機能' do
      before do 
        Login_as(user)
        visit diary_path(diary.id)
      end

      it '日記を消去することができる', js: true do
        page.accept_confirm { find("#button-delete-#{diary.id}").click }
        expect(current_path).to eq diaries_path
        expect(page).to have_content("it has beed deleted")
      end
    end
  end
end
