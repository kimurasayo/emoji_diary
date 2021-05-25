class Diary < ApplicationRecord
  belongs_to :user

  #感情を表す絵文字は必須
  validates :feeling, presence: true
  #日記の日付は必須、一日一日記の制限
  validates :start_time, presence: true, uniqueness: true

  # validateに定義したメソッドを設定
  validate :start_time_cannot_be_in_the_future
  
  # 生年月日の未来日のチェックメソッド
  def start_time_cannot_be_in_the_future
    # 日時が入力済かつ未来日(現在日付より未来)
    if start_time.present? && start_time > Date.today
      # エラー対象とするプロパティとエラーメッセージを設定
      errors.add(:start_time, "can not specify your future date as date.")
    end
  end
end
