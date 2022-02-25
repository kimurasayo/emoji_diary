class User < ApplicationRecord
  # sorceryのメソッド。Userモデルで必要なクラスメソッドとインスタンスメソッドを得ることができる。
  authenticates_with_sorcery!

  # Diaryモデルとのアソシエーション、ユーザーが消されたら日記も消す
  has_many :diaries, dependent: :destroy

  # Relationshipモデルとのアソシエーション、ユーザーが消されたらフォロー情報も消す
  has_many :relationships, dependent: :destroy
  # following=フォローしている人を取得する、relationshipモデルのfollowerを参照する
  has_many :followings, through: :relationships, source: :follower

  # passive_relationshipsは別名。follower_idを入り口にして、class_name: 'Relationship'をつけて参照モデルを指定。
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  # Userはたくさんのfollowersをpassive_relationshipsを通じて持っている。relationshipのuserを参照する
  has_many :followers, through: :passive_relationships, source: :user

  # 各ユーザーはたくさんブックマークをすることが出来る
  has_many :bookmarks, dependent: :destroy
  # お気に入りにしている日記を取得する
  has_many :bookmark_diaries, through: :bookmarks, source: :diary

  # パスワードは半角英数字数字のみ可能。
  VALID_PASSWORD_REGEX = /\A[a-zA-Z0-9]+\z/.freeze

  # if~内容変更時パスワードの入力を省略させることが出来る。パスワードの長さは8文字以上。
  validates :password, length: { minimum: 8 }, format: { with: VALID_PASSWORD_REGEX, message: '半角英数字のみ使用できます' }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  # emailのバリデーション
  # コールバック。emailをセーブする前に全て小文字にする
  before_save { self.email = email.downcase }
  # emailの形式になっていてる確認する。@や.など必須項目があるか確認する
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  # emailは必須条件、一意であることを確認するときに大文字小文字の区別をしている
  validates :email, { presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false } }

  # nicknameは必須項目
  validates :nickname, presence: true

  # nameはTwitterでいうユーザーIDのようなもの。一意で必須項目。15文字以内。半角英数字のみ。
  validates :name, uniqueness: true, presence: true, length: { maximum: 15 }, format: { with: /\A[a-zA-Z0-9]+\z/, message: '半角英数字のみ使用できます' }

  # 一般ユーザー、管理者、ゲストユーザー
  enum role: { general: 0, admin: 1 }

  # サイトのテーマカラー
  enum color: { pink: 0, blue: 1 }

  # フォローする
  def follow(other_user)
    # 自分自身はフォローできない
    return if self == other_user

    relationships.find_or_create_by!(follower: other_user)
  end

  # フォローしているか確認する
  def following?(user)
    followings.include?(user)
  end

  # 　フォローをはずす
  def unfollow(relathinoship_id)
    relationships.find(relathinoship_id).destroy!
  end

  # ブックマークする
  def bookmark(diary)
    bookmark_diaries << diary
  end

  # ブックマークを外す
  def unbookmark(diary)
    bookmark_diaries.delete(diary)
  end

  # ブックマークしているか判定するメソッド
  def bookmark?(diary)
    bookmark_diaries.include?(diary)
  end

  # nicknameに使うランダム絵文字
  def emoji_nickname
    ["\u{1F47B}", "\u{1F47E}", "\u{1F916}", "\u{1F63A}", "\u{1F440}", "\u{1F9DA}", "\u{1F9DB}", "\u{1F9DC}", "\u{1F9DE}", "\u{1F483}", "\u{1F57A}", "\u{1F435}", "\u{1F412}", "\u{1F98D}", "\u{1F436}", "\u{1F415}", "\u{1F429}", "\u{1F43A}", "\u{1F98A}", "\u{1F99D}", "\u{1F431}", "\u{1F408}", "\u{1F981}", "\u{1F42F}", "\u{1F405}", "\u{1F406}", "\u{1F434}",
      "\u{1F40E}", "\u{1F984}", "\u{1F993}", "\u{1F98C}", "\u{1F42E}", "\u{1F404}", "\u{1F437}", "\u{1F416}", "\u{1F417}", "\u{1F40F}", "\u{1F411}", "\u{1F47B}", "\u{1F42A}", "\u{1F999}", "\u{1F992}", "\u{1F418}", "\u{1F98F}", "\u{1F42D}", "\u{1F401}", "\u{1F400}", "\u{1F439}", "\u{1F430}", "\u{1F407}", "\u{1F43F}", "\u{1F9AB}", "\u{1F994}", "\u{1F987}",
      "\u{1F43B}", "\u{1F428}", "\u{1F43C}", "\u{1F9A5}", "\u{1F9A6}", "\u{1F9A8}", "\u{1F998}", "\u{1F9A1}", "\u{1F43E}", "\u{1F983}", "\u{1F414}", "\u{1F413}", "\u{1F423}", "\u{1F424}", "\u{1F425}", "\u{1F426}", "\u{1F427}", "\u{1F54A}", "\u{1F985}", "\u{1F986}", "\u{1F9A2}", "\u{1F989}", "\u{1F9A4}", "\u{1FAB6}", "\u{1F9A9}", "\u{1F99A}", "\u{1F99C}",
      "\u{1F438}", "\u{1F40A}", "\u{1F422}", "\u{1F98E}", "\u{1F40D}", "\u{1F432}", "\u{1F409}", "\u{1F995}", "\u{1F996}", "\u{1F433}", "\u{1F40B}", "\u{1F42C}", "\u{1F9AD}", "\u{1F41F}", "\u{1F420}", "\u{1F421}", "\u{1F988}", "\u{1F419}", "\u{1F41A}", "\u{1F40C}", "\u{1F98B}", "\u{1F41B}", "\u{1F41C}", "\u{1F41D}", "\u{1F41E}", "\u{1F490}", "\u{1F338}",
      "\u{1F339}", "\u{1F33A}", "\u{1F33B}", "\u{1F33C}", "\u{1F337}", "\u{1F331}", "\u{1FAB4}", "\u{1F332}", "\u{1F333}", "\u{1F334}", "\u{1F335}", "\u{1F33E}", "\u{1F33F}", "\u{1F340}", "\u{1F341}", "\u{1F342}", "\u{1F343}", "\u{1F347}", "\u{1F348}", "\u{1F349}", "\u{1F34A}", "\u{1F34B}", "\u{1F34C}", "\u{1F34D}", "\u{1F96D}", "\u{1F34E}", "\u{1F34F}",
      "\u{1F350}", "\u{1F351}", "\u{1F352}", "\u{1F353}", "\u{1FAD0}", "\u{1F95D}", "\u{1F345}", "\u{1F965}", "\u{1F951}", "\u{1F346}", "\u{1F955}", "\u{1F33D}", "\u{1F344}", "\u{1F95C}", "\u{1F330}", "\u{1F96F}", "\u{1F95E}", "\u{1F9CO}", "\u{1F356}", "\u{1F357}", "\u{1F354}", "\u{1F35F}", "\u{1F355}", "\u{1F32D}", "\u{1F96A}", "\u{1F37F}", "\u{1F96B}",
      "\u{1F359}", "\u{1F362}", "\u{1F360}", "\u{1F363}", "\u{1F364}", "\u{1F365}", "\u{1F361}", "\u{1F980}", "\u{1F99E}", "\u{1F990}", "\u{1F366}", "\u{1F367}", "\u{1F368}", "\u{1F369}", "\u{1F370}", "\u{1F9C1}", "\u{1F36B}", "\u{1F36C}", "\u{1F36D}", "\u{1F36E}", "\u{1F36F}", "\u{1F37C}", "\u{1F9C3}", "\u{1F3D5}", "\u{1F30B}", "\u{1F3D6}", "\u{1F3DC}",
      "\u{1F3DD}", "\u{1F3DF}", "\u{1F3A0}", "\u{1F3A1}", "\u{1F6FC}", "\u{1FA82}", "\u{1F681}", "\u{1F680}", "\u{1FA90}", "\u{1F384}", "\u{1F383}", "\u{1F380}", "\u{1F3A3}", "\u{1F3BF}", "\u{1FA81}", "\u{1F9F8}", "\u{1FA86}", "\u{1F3A8}", "\u{1F9F5}", "\u{1FA70}", "\u{1F48E}", "\u{1F941}", "\u{1F516}", "\u{1F3F9}"].sample
  end

  def to_param
    name
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.hex(10)
      user.password_confirmation = user.password
      user.name = 'guest'
      user.nickname = '🔰'
    end
  end

  def self.other_user
    find_or_create_by!(email: 'guest2@example.com') do |user|
      user.password = SecureRandom.hex(10)
      user.password_confirmation = user.password
      user.name = 'guest2'
      user.nickname = '🍑'
    end
  end
end
