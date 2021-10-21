class Diary < ApplicationRecord
  belongs_to :user

  # 各日記はたくさんのブックマークをもつことが出来る
  has_many :bookmarks, dependent: :destroy

  # 感情を表す絵文字は1つ必須
  validates :feeling, presence: true,
                      format: { with: /["😀", "😃", "😄", "😁", "😆", "😅", "🤣", "😂", "😉", "😊", "😇", "🤗", "😋", "😝", "🙂", "😎", "🤠", "🤩", "🥰", "😍",
                              "😘", "😗", "😚", "😙", "😛", "😜", "🤪", "🤑", "🥳", "🤤", "😳", "🤓", "😌", "🥸", "😲", "😯", "😮", "😬", "🤭", "🤫", "🤔", "🤐", "🤨",
                              "🧐", "😏", "😒", "🙃", "🙄", "🤥", "🥺", "🥲", "😞", "😥", "😢", "😭", "😓", "😔", "😣", "😩", "😵", "😷", "🤕", "🤢", "🤮", "🤧", "🥵",
                              "🥶", "🥴", "🤒", "😐", "😶", "😑", "😕", "😟", "🙁", "😖", "😫", "🥱", "😪", "😴", "😦", "😧", "😨", "😰", "😱", "🤯", "😤", "😡", "😠",
                              "🤬", "😈", "👿"]/,
                                          message: "絵文字だけ入力できます" },
                      length: { maximum: 1 }

  # バリデーターにて使用できる文字を定義している
  validates :body, emoji: true, length: { maximum: 160 }

  # 日記の日付は必須
  validates :start_time, presence: true

  # validateに下記で定義したメソッドを設定
  validate :start_time_cannot_be_in_the_future

  validates :start_time, uniqueness: { scope: :user }

  # 最終更新日から30日分の日記の感情だけを表示するためのスコープ
  scope :current_month, -> { where(start_time: Time.now - 30.days..Time.now) }

  # 生年月日の未来日のチェックメソッド
  def start_time_cannot_be_in_the_future
    # 日時が入力済かつ未来日(現在日付より未来)ならば、エラー対象とするプロパティとエラーメッセージを設定
    errors.add(:start_time, "未来の日付は入力できません") if start_time.present? && start_time > Date.today
  end

  def score_feeling
    case self.feeling
    when "🤩", "🥰", "😍", "😘", "🥳", "🤪"
      self.score = 100
    when "😋", "😜", "😝", "🤗", "😳", "🤣", "😂"
      self.score = 90
    when "😁", "😆", "😊", "😇", "🤤", "😎", "😚"
      self.score = 80
    when "😅", "😉", "😃", "😙", "😄", "🤑"
      self.score = 70
    when "😌", "🤓", "😏", "😛", "😗", "😀", "🙂", "🙃"
      self.score = 60
    when "😐", "😑", "😶", "😒", "🙄", "😬", "😲", "🥺", "🤐", "🤔", "🤠"
      self.score = 50
    when "🤭", "🤫", "🤨", "🤥", "🧐", "😕", "😟", "🙁", "😦", "😧", "🥸", "😯", "😮", "🥲"
      self.score = 40
    when "😤", "😠", "😪", "😴", "😨", "😰", "😢", "😥", "😞", "😓", "😔", "🥱"
      self.score = 30
    when "😷", "🤕", "🤧", "🥵", "🥶", "🥴", "😵", "😡", "😣", "🤯", "😩", "🤒"
      self.score = 20
    when "😭", "😱", "😖", "😫", "🤬", "😈", "👿", "🤢", "🤮"
      self.score = 10
    end
  end
end
