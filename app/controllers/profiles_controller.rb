class ProfilesController < ApplicationController
  # profiles_path
  def show; end

  # DBから取得したオブジェクトを使用する。
  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to profiles_path
    else
      render :edit
    end
  end

  private

  # パラメーターで送ることができるカラムの情報
  def user_params
    params.require(:user).permit(:nickname, :name)
  end
end
