class BookmarksController < ApplicationController
  # pagyを導入
  include Pagy::Backend

  # ブックマークする
  def create
    @diary = Diary.find(params[:diary_id])
    current_user.bookmark(@diary)
  end

  # ブックマークを外す
  def destroy
    @diary = current_user.bookmarks.find(params[:id]).diary
    current_user.unbookmark(@diary)
  end

  # 日記にブックマークしているユーザー一覧のページ
  def index
    @diary = Diary.find(params[:id])
    @user = @diary.user
    @bookmarks = Bookmark.where(diary_id: @diary.id).all
    @pagy, @bookmarks = pagy(Bookmark.where(diary_id: @diary.id).all)
  end
end
