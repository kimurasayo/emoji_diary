class FollowersController < ApplicationController
  # pagyを導入
  include Pagy::Backend

  # user_followers_path, 友達一覧画面
  def index
    @users = current_user.followings
    @diaries = Diary.all.order(start_time: :desc).includes(:user).where(user_id: @users)
    @pagy, @diaries = pagy(@diaries)
  end
end
