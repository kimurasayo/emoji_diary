class TopsController < ApplicationController
  # トップページにアクセスする前にrequire_loginを行わない
  skip_before_action :require_login

  def home; end

  def privacy; end

  def uses; end
end
