class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[edit update]

  # profiles_path
  def show; end

  # DBから取得したオブジェクトを使用する。
  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profiles_path
    else
      render :edit
    end
  end

  private

  # パラメーターで送ることができるカラムの情報
  def user_params
    params.require(:user).permit(:nickname, :name, :password, :password_confirmation, :email)
  end

  def set_profile
    @user = User.find(current_user.id)
  end
end
