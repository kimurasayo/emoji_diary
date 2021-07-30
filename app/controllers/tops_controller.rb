class TopsController < ApplicationController
  # トップページにアクセスする前にrequire_loginを行わない
  skip_before_action :require_login, only: %i[home privacy uses index]

  def home; end

  def privacy; end

  def uses; end

  def line; end

  def index
    @diaries = Diary.all
  end
end
