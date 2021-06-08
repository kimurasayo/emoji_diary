class UsersController < ApplicationController
  # new, createアクション(新規作成)の前にrequire_loginを行わない
  skip_before_action :require_login, only: [:new, :create]

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
    if @user.save
      redirect_to login_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  # フォローしている人全員
  def following
    @users = current_user.followings
  end

  # フォロワー全員
  def follower
    @users = current_user.followers
  end

  # ransackを使って検索したユーザーを@qに入れている
  # ユーザー検索の結果
  def search
    @q = User.search(search_params)
    @users = @q.result(distinct: true)
  end

  private

  # パラメーターで送ることができるカラムの情報
  def user_params
    params.require(:user).permit(:nickname, :name, :password, :password_confirmation)
  end

  # ユーザー検索で受け取ることができるカラムの情報
  def search_params
    params.require(:q).permit(:name_cont)
  end
end
