class UserSessionsController < ApplicationController
  def new; end

  # ログイン時はnameとpasswordの情報でDBからユーザーを探す
  # もしユーザーが探せたらトップページに遷移、一致しなかったらログインページに遷移
  def create
    @user = login(params[:name], params[:password])
    if @user
      redirect_back_or_to root_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  # ログアウト、トップページに遷移する
  def destroy
    logout
    flash[:success] = t('.success')
    redirect_to root_path
  end
end
