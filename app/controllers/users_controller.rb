class UsersController < ApplicationController
  # 新規作成したユーザー
  def new
    @user = User.new
  end

  # 新規作成するユーザー情報
  def create
    @user = User.new(user_params)
      if @user.save
        redirect_to login_path
      else
        render :new
      end
  end

  private
    # パラメーターで送ることができるカラムの情報
    def user_params
      params.require(:user).permit(:nickname, :name, :password, :password_confirmation)
    end
end
