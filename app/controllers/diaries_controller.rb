class DiariesController < ApplicationController
  before_action :set_diary, only: %i[edit update destroy]
  # user_diaries_path。ユーザーのidをパラメータで受け取って、@userに入れる。
  # @userの日記一覧を@diariesに入れる。
  def index
    # @user = User.find(params[:user_id])
    # userのnemeをパラメータで取得してユーザーを指定する
    @user = User.find_by(name: params[:user_name])
    @diaries = @user.diaries
  end

  # new_user_diary_path
  def new
    @diary = Diary.new
  end

  # user_diary_path。現在アクセスしている日記のidを取得、それを使い日記の所有者のユーザーidを使いユーザーを特定
  def show
    @diary = Diary.find(params[:id])
    @user = @diary.user
  end

  # 日記作成アクション。作成できたら一覧ページ、失敗したら日記新規作成ページへ。
  def create
    @diary = current_user.diaries.new(diary_params)
    # モデルにメソッド記載
    @diary.score_feeling
    if @diary.save
      redirect_to user_diary_path(current_user.name, @diary), success: t('.success', date: @diary.start_time.strftime("%-m月%-e日"))
    else
      render :new
    end
  end

  # 日記消去アクション
  def destroy
    @diary.destroy
    redirect_to user_diaries_path(current_user.name), success: t('.success', date: @diary.start_time.strftime("%-m月%-e日"))
  end

  # edit_user_diary_path
  def edit; end

  # 日記更新アクション。作成できたら一覧ページ、失敗したら日記編集ページへ。
  def update
    if @diary.update(diary_params)
      @diary.score_feeling
      @diary.save
      redirect_to user_diary_path(current_user.name, @diary), success: t('.success', date: @diary.start_time.strftime("%-m月%e日"))
    else
      render :edit
    end
  end

  private

  # フォームから受け取ることのできる情報カラム
  def diary_params
    params.require(:diary).permit(:feeling, :body, :start_time)
  end

  def set_diary
    @diary = current_user.diaries.find(params[:id])
  end
end
