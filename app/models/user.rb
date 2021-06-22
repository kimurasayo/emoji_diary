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
  VALID_PASSWORD_REGEX = /\A[a-zA-Z0-9]+\z/

  # if~内容変更時パスワードの入力を省略させることが出来る。パスワードの長さは6-12文字。
  validates :password, length: { in: 6..12 }, format: { with: VALID_PASSWORD_REGEX}, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  # emailは必須条件、一意であること
  validates :email, uniqueness: true, presence: true

  # nicknameは必須項目
  validates :nickname, presence: true

  # nameはTwitterでいうユーザーIDのようなもの。一意で必須項目。15文字以内。半角英数字のみ。
  validates :name, uniqueness: true, presence: true, length: { maximum: 15 }, format: { with: /\A[a-zA-Z0-9]+\z/ }

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
end
