class GuestSessionsController < ApplicationController
  skip_before_action :require_login

  def create
    @user = User.guest
    auto_login(@user)
    @diary14 = Diary.new(feeling: '🥳', body: '🙌🎉🎈', start_time: Date.today, user_id: @user.id)
    @diary14.score_feeling
    @diary14.save
    @diary = Diary.new(feeling: '😁', body: '🍫🥤🤤', start_time: Date.yesterday, user_id: @user.id)
    @diary.score_feeling
    @diary.save
    @diary1 = Diary.new(feeling: '😑', body: '🤦🏻‍♀️🌧🛌', start_time: Date.today.days_ago(2), user_id: @user.id)
    @diary1.score_feeling
    @diary1.save
    @diary2 = Diary.new(feeling: '😭', body: '🤯⛈🍜', start_time: Date.today.days_ago(3), user_id: @user.id)
    @diary2.score_feeling
    @diary2.save
    @diary3 = Diary.new(feeling: '🥰', body: '💐🍝🥗🚗🌉', start_time: Date.today.days_ago(4), user_id: @user.id)
    @diary3.score_feeling
    @diary3.save
    @diary4 = Diary.new(feeling: '🤓', body: '💻🤯🤔💡💡🙌', start_time: Date.today.days_ago(5), user_id: @user.id)
    @diary4.score_feeling
    @diary4.save
    @diary5 = Diary.new(feeling: '😋', body: '🍑🍉🥩🐷❤️', start_time: Date.today.days_ago(6), user_id: @user.id)
    @diary5.score_feeling
    @diary5.save
    @diary6 = Diary.new(feeling: '🤒', body: '🛌💊🏥', start_time: Date.today.days_ago(7), user_id: @user.id)
    @diary6.score_feeling
    @diary6.save
    @other_user = User.other_user
    @user.follow(@other_user)
    @other_user.follow(@user)
    @diary15 = Diary.new(feeling: '😌', body: '📚👓🤓', start_time: Date.today, user_id: @other_user.id)
    @diary15.score_feeling
    @diary15.save
    @diary7 = Diary.new(feeling: '🥳', body: '🧔🏻🎂🎊🎁', start_time: Date.yesterday, user_id: @other_user.id)
    @diary7.score_feeling
    @diary7.save
    @diary8 = Diary.new(feeling: '😂', body: '🎬🎞👩🏻❤️', start_time: Date.today.days_ago(2), user_id: @other_user.id)
    @diary8.score_feeling
    @diary8.save
    @diary9 = Diary.new(feeling: '😊', body: '☀️🏃🏻‍♀️🦵🏻🥤🥩', start_time: Date.today.days_ago(3), user_id: @other_user.id)
    @diary9.score_feeling
    @diary9.save
    @diary10 = Diary.new(feeling: '😡', body: '🧠🔥', start_time: Date.today.days_ago(4), user_id: @other_user.id)
    @diary10.score_feeling
    @diary10.save
    @diary11 = Diary.new(feeling: '😕', body: '🤯🤔💧', start_time: Date.today.days_ago(5), user_id: @other_user.id)
    @diary11.score_feeling
    @diary11.save
    @diary12 = Diary.new(feeling: '😱', body: '👩🏻‍💻😵🍺🍺', start_time: Date.today.days_ago(6), user_id: @other_user.id)
    @diary12.score_feeling
    @diary12.save
    @diary13 = Diary.new(feeling: '😴', body: '😴😴😴', start_time: Date.today.days_ago(7), user_id: @other_user.id)
    @diary13.score_feeling
    @diary13.save
    redirect_to user_diaries_path(@user), success: 'ゲストユーザーでログインしました'
  end
end
