class RelationshipsController < ApplicationController
  # フォローする
  def create
    # パラメータでfollower_idを取得
    @other_user = User.find(params[:follower])
    # 現在ログインしているユーザーが@other_userをフォローする
    current_user.follow(@other_user)
    # 処理が終わったら同じページに戻る
		redirect_back fallback_location: root_path
  end

  def destroy
    # 現在ログインしているユーザーのフォロー情報をrelationshipsテーブルのfollower_idから取得
    @user = current_user.relationships.find(params[:id]).follower
    # 現在ログインしているユーザーがフォローを外す
    current_user.unfollow(params[:id])
    # 処理が終わったら同じページに戻る
		redirect_back fallback_location: root_path
  end
end
