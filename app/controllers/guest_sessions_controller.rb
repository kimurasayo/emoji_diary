class GuestSessionsController < ApplicationController
  skip_before_action :require_login

  def create
    @user = User.guest
    auto_login(@user)
    redirect_to user_diaries_path(@user), success: 'ゲストユーザーでログインしました'
  end
end
