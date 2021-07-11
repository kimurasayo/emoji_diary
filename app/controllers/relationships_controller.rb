class RelationshipsController < ApplicationController
  # フォローする
  def create
    # パラメータでfollower_idを取得
    @other_user = User.find(params[:follower])
    # 現在ログインしているユーザーが@other_userをフォローする
    current_user.follow(@other_user)
  end

  # フォローを外す
  def destroy
    # 現在ログインしているユーザーのフォロー情報をrelationshipsテーブルのfollower_idから取得
    @user = current_user.relationships.find(params[:id]).follower
    # 現在ログインしているユーザーがフォローを外す
    current_user.unfollow(params[:id])
  end
end
