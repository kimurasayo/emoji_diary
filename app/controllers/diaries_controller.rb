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

  # user_diary_path。現在アクセスしている日記のidを取得、それを使い日記の所有者のユーザーidを使いユーザーを特定
  def show
    @diary = Diary.find(params[:id])
    @user = @diary.user
  end

  # 日記作成アクション。作成できたら一覧ページ、失敗したら日記新規作成ページへ。
  def create
    @diary = current_user.diaries.new(diary_params)
    score_feeling
    if @diary.save
      redirect_to user_diaries_path(current_user)
    else
      render :new
    end
  end

  # 日記消去アクション
  def destroy
    @diary = current_user.diaries.find(params[:id])
    @diary.destroy
    redirect_to user_diaries_path(current_user)
  end

  # edit_user_diary_path
  def edit
    @diary = current_user.diaries.find(params[:id])
  end

  # 日記更新アクション。作成できたら一覧ページ、失敗したら日記編集ページへ。
  def update
    @diary = current_user.diaries.find(params[:id])
    score_feeling
    if @diary.update(diary_params)
      redirect_to user_diary_path(current_user)
    else
      render :edit
    end
  end

  private

  # フォームから受け取ることのできる情報カラム
  def diary_params
    params.require(:diary).permit(:feeling, :body, :start_time)
  end

  def score_feeling
    case @diary.feeling
    when "🤩", "🥰", "😍", "😘", "🥳", "🤪"
      @diary.score = 100
    when "😋", "😜", "😝", "🤗", "😳", "🤣", "😂"
      @diary.score = 90
    when "😁", "😆", "😊", "😇", "🤤", "😎", "😚"
      @diary.score = 80
    when "😅", "😉", "😃", "😙", "😄", "🤑"
      @diary.score = 70
    when "😌", "🤓", "😏", "😛", "😗", "😀", "🙂", "🙃"
      @diary.score = 60
    when "😐", "😑", "😶", "😒", "🙄", "😬", "😲", "🥺", "🤐", "🤔", "🤠"
      @diary.score = 50
    when "🤭", "🤫", "🤨", "🤥", "🧐", "😕", "😟", "🙁", "😦", "😧", "🥸", "😯", "😮", "🥲"
      @diary.score = 40
    when "😤", "😠", "😪", "😴", "😨", "😰", "😢", "😥", "😞", "😓", "😔", "🥱"
      @diary.score = 30
    when "😷", "🤕", "🤧", "🥵", "🥶", "🥴", "😵", "😡", "😣", "🤯", "😩", "🤒"
      @diary.score = 20
    when "😭", "😱", "😖", "😫", "🤬", "😈", "👿", "🤢", "🤮"
      @diary.score = 10
    end
  end
end
