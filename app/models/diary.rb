class Diary < ApplicationRecord
  belongs_to :user

  # 各日記はたくさんのブックマークをもつことが出来る
  has_many :bookmarks, dependent: :destroy

  # 感情を表す絵文字は必須
  validates :feeling, presence: true

  # バリデーターにて使用できる文字を定義している
  validates :body, emoji: true, lots_of_emoji: true

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
    errors.add(:start_time, '未来の日付は入力できません') if start_time.present? && start_time > Date.today
  end

  def score_feeling
    case feeling
    when "\u{1F929}", "\u{1F970}", "\u{1F60D}", "\u{1F618}", "\u{1F973}", "\u{1F92A}"
      self.score = 100
    when "\u{1F60B}", "\u{1F61C}", "\u{1F61D}", "\u{1F917}", "\u{1F633}", "\u{1F923}", "\u{1F602}"
      self.score = 90
    when "\u{1F601}", "\u{1F606}", "\u{1F60A}", "\u{1F607}", "\u{1F924}", "\u{1F60E}", "\u{1F61A}"
      self.score = 80
    when "\u{1F605}", "\u{1F609}", "\u{1F603}", "\u{1F619}", "\u{1F604}", "\u{1F911}"
      self.score = 70
    when "\u{1F60C}", "\u{1F913}", "\u{1F60F}", "\u{1F61B}", "\u{1F617}", "\u{1F600}", "\u{1F642}", "\u{1F643}"
      self.score = 60
    when "\u{1F610}", "\u{1F611}", "\u{1F636}", "\u{1F612}", "\u{1F644}", "\u{1F62C}", "\u{1F632}", "\u{1F97A}", "\u{1F910}", "\u{1F914}", "\u{1F920}"
      self.score = 50
    when "\u{1F92D}", "\u{1F92B}", "\u{1F928}", "\u{1F925}", "\u{1F9D0}", "\u{1F615}", "\u{1F61F}", "\u{1F641}", "\u{1F626}", "\u{1F627}", "\u{1F978}", "\u{1F62F}", "\u{1F62E}", "\u{1F972}"
      self.score = 40
    when "\u{1F624}", "\u{1F620}", "\u{1F62A}", "\u{1F634}", "\u{1F628}", "\u{1F630}", "\u{1F622}", "\u{1F625}", "\u{1F61E}", "\u{1F613}", "\u{1F614}", "\u{1F971}"
      self.score = 30
    when "\u{1F637}", "\u{1F915}", "\u{1F927}", "\u{1F975}", "\u{1F976}", "\u{1F974}", "\u{1F635}", "\u{1F621}", "\u{1F623}", "\u{1F92F}", "\u{1F629}", "\u{1F912}"
      self.score = 20
    when "\u{1F62D}", "\u{1F631}", "\u{1F616}", "\u{1F62B}", "\u{1F92C}", "\u{1F608}", "\u{1F47F}", "\u{1F922}", "\u{1F92E}"
      self.score = 10
    end
  end

  def previous
    Diary.where(user_id: user.id).where('start_time < ?', start_time).order('start_time DESC').first
  end

  def next
    Diary.where(user_id: user.id).where('start_time > ?', start_time).order('start_time ASC').first
  end
end
