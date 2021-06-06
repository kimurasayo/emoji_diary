class FollowersController < ApplicationController
  # user_followers_path
  def index
    @user = current_user
    @users = @user.followings
  end
end
