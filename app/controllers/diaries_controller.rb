class DiariesController < ApplicationController
  # user_diaries_path。ユーザーのidをパラメータで受け取って、@userに入れる。
  # @userの日記一覧を@diariesに入れる。
  def index
    @user = User.find(params[:user_id])
    @diaries = @user.diaries
  end

  # new_user_diary_path
  def new
    @diary = Diary.new
  end

  # user_diary_path。ユーザーの情報から日記の記事を絞り込んで、@diaryに入れている。
  def show
    @user = User.find(params[:user_id])
    @diary = @user.diaries.find(params[:id])
  end

  # 日記作成アクション。作成できたら一覧ページ、失敗したら日記新規作成ページへ。
  def create
    @diary = current_user.diaries.new(diary_params)
    if @diary.save
      redirect_to user_diaries_path(current_user), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  # 日記消去アクション
  def destroy
    @diary = current_user.diaries.find(params[:id])
    @diary.destroy
    redirect_to user_diaries_path(current_user), success: t('.success')
  end

  # edit_user_diary_path
  def edit
    @diary = current_user.diaries.find(params[:id])
  end

  # 日記更新アクション。作成できたら一覧ページ、失敗したら日記編集ページへ。
  def update
    @diary = current_user.diaries.find(params[:id])
    if @diary.update(diary_params)
      redirect_to user_diary_path(current_user), success: t('.success')
    else
      render :edit
    end
  end

  # 日記にブックマークしているユーザー一覧のページ
  def index_bookmarks
    @diary = Diary.find(params[:id])
    @bookmarks = Bookmark.where(diary_id: @diary.id).all
  end

  private

  # フォームから受け取ることのできる情報カラム
  def diary_params
    params.require(:diary).permit(:feeling, :body, :start_time)
  end
end
