class UsersController < ApplicationController
  # new, createアクション(新規作成)の前にrequire_loginを行わない
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[following follower]

  # pagyを導入
  include Pagy::Backend

  # ransackを使って検索したユーザーを@qに入れている
  # ユーザー検索ページ
  def index
    if current_user.name == 'guest'
      redirect_to user_diaries_path(current_user), success: '『ゲスト』はユーザー検索できません'
    else
      @q = User.ransack(params[:q])
    end
  end

  # 新規作成したユーザー
  def new
    @user = User.new
    redirect_to user_diaries_path(current_user.name), danger: t('.fail') if current_user
  end

  # 新規作成するユーザー情報
  def create
    @user = User.new(user_params)
    @user.nickname = @user.emoji_nickname
    if @user.save
      auto_login(@user)
      redirect_to new_user_diary_path(@user), success: t('.success')
    else
      render :new
    end
  end

  # 退会
  def destroy
    # 　@user = User.find(params[:id])
    # userのnemeをパラメータで取得してユーザーを指定する
    if current_user.name == 'guest'
      redirect_to profiles_path, success: '『ゲスト』は退会できません'
    else
      @user = User.find_by(name: params[:name])
      @user.destroy
      redirect_to root_path, success: t('.success')
    end
  end

  # フォローしている人全員
  def following
    @pagy, @users = pagy(@user.followings)
  end

  # フォロワー全員
  def follower
    @pagy, @users = pagy(@user.followers)
  end

  # ransackを使って検索したユーザーを@qに入れている
  # ユーザー検索の結果
  def search
    @q = User.search(search_params)
    @pagy, @users = pagy(@q.result(distinct: true))
  end

  private

  # パラメーターで送ることができるカラムの情報
  def user_params
    params.require(:user).permit(:nickname, :name, :password, :password_confirmation, :email, :color)
  end

  # ユーザー検索で受け取ることができるカラムの情報
  def search_params
    params.require(:q).permit(:name_cont)
  end

  def set_user
    # 　@user = User.find(params[:user_id])
    # userのnemeをパラメータで取得してユーザーを指定する
    @user = User.find_by(name: params[:user_name])
  end
end
