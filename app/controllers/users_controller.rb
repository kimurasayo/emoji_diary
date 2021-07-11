class UsersController < ApplicationController
  # new, createアクション(新規作成)の前にrequire_loginを行わない
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[following follower]

  # pagyを導入
  include Pagy::Backend

  # ransackを使って検索したユーザーを@qに入れている
  # ユーザー検索ページ
  def index
    @q = User.ransack(params[:q])
  end

  # 新規作成したユーザー
  def new
    @user = User.new
  end

  # 新規作成するユーザー情報
  def create
    @user = User.new(user_params)
    @user.nickname = @user.emoji_nickname
    if @user.save
      auto_login(@user)
      redirect_to new_user_diary_path(@user)
    else
      render :new
    end
  end

  # 退会
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, success: 'thank you'
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
    params.require(:user).permit(:nickname, :name, :password, :password_confirmation, :email)
  end

  # ユーザー検索で受け取ることができるカラムの情報
  def search_params
    params.require(:q).permit(:name_cont)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
