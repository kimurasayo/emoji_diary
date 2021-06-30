class ApplicationController < ActionController::Base
  # 使用できるフラッシュメッセージの種類を増やしている
  add_flash_types :success, :info, :warning, :danger

  # デフォルトでrequire_loginをアクションの前に行う設定
  before_action :require_login

  private

  # ログインしていないユーザーがアクセスしてrequire_loginで弾かれた後の処理
  def not_authenticated
    redirect_to main_app.login_path, danger: "Please login first"
  end
end
