class FollowersController < ApplicationController
  # user_followers_path
  def index
    @users = current_user.followings
  end
end
