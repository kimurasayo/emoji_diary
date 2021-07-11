class FollowersController < ApplicationController
  # pagyを導入
  include Pagy::Backend

  # user_followers_path, 友達一覧画面
  def index
    @q = current_user.followings.ransack(params[:q])
    @users = @q.result(distinct: true)
    @pagy, @users = pagy(@q.result(distinct: true))
  end
end
