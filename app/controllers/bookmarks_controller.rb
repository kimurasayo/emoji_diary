class BookmarksController < ApplicationController
  # ブックマークする
  def create
    diary = Diary.find(params[:diary_id])
    current_user.bookmark(diary)
    redirect_back fallback_location: root_path
  end

  # ブックマークを外す
  def destroy
    diary = current_user.bookmarks.find(params[:id]).diary
    current_user.unbookmark(diary)
    redirect_back fallback_location: root_path
  end

  # 日記にブックマークしているユーザー一覧のページ
  def index
    @diary = Diary.find(params[:id])
    @bookmarks = Bookmark.where(diary_id: @diary.id).all
  end
end
