class DiariesController < ApplicationController
  
  # diaries_path。現在ログインしているユーザーの日記一覧ページ。
  def index
    @diaries = current_user.diaries
  end

  # new_diary_path
  def new
    @diary = Diary.new
  end

  # diary_path
  def show
    @diary = current_user.diaries.find(params[:id])
  end

  # 日記作成アクション。作成できたら一覧ページ、失敗したら日記新規作成ページへ。
  def create
    @diary = current_user.diaries.new(diary_params)
    if @diary.save
      redirect_to diaries_path, success: "#{@diary.feeling} in #{@diary.start_time}"
    else
      render :new
    end
  end

  # diary_path(@diary.id), method: :delete
  def destroy
    @diary = current_user.diaries.find(params[:id])
    @diary.destroy
    redirect_to diaries_path, success:"it has beed deleted"
  end
  
  # edit_diary_path(@diary.id)
  def edit
    @diary = current_user.diaries.find(params[:id])
  end

  # 日記更新アクション。作成できたら一覧ページ、失敗したら日記編集ページへ。
  def update
    @diary = current_user.diaries.find(params[:id])
    if @diary.update(diary_params)
      redirect_to diaries_path, success: "it has been updated"
    else
      render :edit
    end
  end

  private

  #フォームから受け取ることのできる情報カラム
  def diary_params
    params.require(:diary).permit(:feeling, :body, :start_time)
  end
end
