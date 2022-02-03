class UserSessionsController < ApplicationController
  # new, createアクション(ログイン)の前にrequire_loginを行わない
  skip_before_action :require_login, only: %i[new create]

  def new
    redirect_to user_diaries_path(current_user.name), danger: t('.fail') if current_user
  end

  # ログイン時はnameとpasswordの情報でDBからユーザーを探す
  # もしユーザーが探せたら自分の日記一覧ページに遷移、一致しなかったらログインページに遷移
  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to user_diaries_path(current_user), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  # ログアウト、トップページに遷移する
  def destroy
    logout
    redirect_to root_path, success: t('.success')
  end
end
