require 'rails_helper'

RSpec.describe "Diaries", type: :system do
  describe '日記のCRUD機能' do
    let(:user) { create(:user) }
    let(:friend) { create(:user, :friend) }
    let(:diary) { create(:diary, user: user) }
    let(:yesterday_diary) { create(:diary, :yesterday, user: user) }

    describe '日記の一覧画面' do
      context 'ログインしている場合' do
        before do
          Login_as(user)
          yesterday_diary
        end

        it 'ヘッダーのmy diaryリンクから日記一覧ページにアクセスできる' do
          click_link 'my diary'
          expect(current_path).to eq user_diaries_path(user)
        end

        it '投稿済みの昨日の日記がある場合、feelingの顔文字🥳が昨日の日付の欄に記載されている' do
          click_link 'my diary'
          expect(current_path).to eq user_diaries_path(user)
          expect(page).to have_content '🥳'
        end
      end

      context 'ログインしていない場合' do
        it '日記一覧ページにアクセスできるが、日記新規作成のリンクは表示されていない' do
          visit user_diaries_path(user)
          expect(current_path).to eq user_diaries_path(user)
          expect(page).not_to have_content 'write diary'
        end
      end
    end

    describe '日記の新規投稿画面' do
      context 'ログインしている場合' do
        before { Login_as(user) }

        it 'write diaryから日記新規投稿ページにアクセスできる' do
          click_link 'write diary'
          expect(current_path).to eq new_user_diary_path(user)
        end

        it '日記が作成できる' do
          click_link 'write diary'
          fill_in 'about', with: '🍓🍟🍰'
          click_on 'save'
          expect(page).to have_content '😀🍓🍟🍰'
        end
      end

      context 'ログインしていない場合' do
        it '日記新規投稿ページにアクセスできず、ログインページに遷移する' do
          visit new_user_diary_path(user)
          expect(current_path).to eq login_path
          expect(page).to have_content 'ログインしてください'
        end
      end
    end

    describe '日記の詳細画面' do
      context 'ログインしている場合' do
        before { Login_as(user) }

        it '日記詳細ページから日記編集ページにアクセスできる' do
          visit user_diary_path(user_name: user.name, id: diary.id)
          click_on "edit"
          expect(current_path).to eq edit_user_diary_path(user_name: user.name, id: diary.id)
        end

        it '他ユーザの日記の詳細ページにはeditボタンは表示されていない' do
          visit user_diary_path(user_name: friend.name, id: diary.id)
          expect(page).not_to have_content 'edit'
        end

        it '他ユーザの日記の詳細ページにはdeleteボタンは表示されていない' do
          visit user_diary_path(user_name: friend.name, id: diary.id)
          expect(page).not_to have_content 'delete'
        end

        it '日記の詳細ページに前の日記へ遷移する<<が表示されている' do
          yesterday_diary
          visit user_diary_path(user_name: user.name, id: diary.id)
          expect(page).to have_selector ".btn_arrow"
        end

        it '日記の詳細ページに前の日記がない場合は<<が表示されない' do
          visit user_diary_path(user_name: user.name, id: diary.id)
          expect(page).not_to have_selector ".btn_arrow"
        end

        it '日記の詳細ページに次の日記へ遷移する>>をクリックすると前日の日記が表示される' do
          yesterday_diary
          visit user_diary_path(user_name: user.name, id: diary.id)
          find(".btn_arrow").click
          expect(current_path).to eq user_diary_path(user_name: user.name, id: yesterday_diary.id)
        end

        it '日記の詳細ページに次の日記がない場合は>>が表示されない' do
          visit user_diary_path(user_name: user.name, id: diary.id)
          expect(page).not_to have_selector ".btn_arrow_back"
        end

        it '日記の詳細ページに前の日記へ遷移する>>をクリックすると前日の日記が表示される' do
          diary
          visit user_diary_path(user_name: user.name, id: yesterday_diary.id)
          find(".btn_arrow_back").click
          expect(current_path).to eq user_diary_path(user_name: user.name, id: diary.id)
        end
      end

      context 'ログインしていない場合' do
        it '日記詳細ページにアクセスできず、ログインページに遷移する' do
          visit user_diary_path(user_name: user.name, id: diary.id)
          expect(current_path).to eq login_path
        end
      end
    end

    describe '日記の編集画面' do
      context 'ログインしている場合' do
        before do
          Login_as(user)
          visit user_diary_path(user_name: user.name, id: diary.id)
          click_on "edit"
        end

        it '日記を編集することができる' do
          fill_in 'about', with: '⚽️🥅'
          click_on 'save'
          expect(current_path).to eq user_diary_path(user_name: user.name, id: diary.id)
          expect(page).to have_content('日記を更新しました')
          expect(page).to have_content('⚽️🥅')
        end
      end

      context 'ログインしていない場合' do
        it '日記編集ページにアクセスできず、ログインページに遷移する' do
          visit edit_user_diary_path(user_name: user.name, id: diary.id)
          expect(current_path).to eq login_path
        end
      end
    end

    describe '日記の削除機能' do
      before do
        Login_as(user)
        visit user_diary_path(user_name: user.name, id: diary.id)
      end

      it '日記を消去することができる' do
        click_on 'delete'
        find(".commit").click
        expect(current_path).to eq user_diaries_path(user_name: user.name)
        expect(page).to have_content("日記を削除しました")
      end
    end
  end
end
