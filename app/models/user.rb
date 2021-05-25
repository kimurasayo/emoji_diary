class User < ApplicationRecord
  # sorceryのメソッド。Userモデルで必要なクラスメソッドとインスタンスメソッドを得ることができる。
  authenticates_with_sorcery!

  # Diaryモデルとのアソシエーション、ユーザーが消されたら日記も消す
  has_many :diaries, dependent: :destroy 

  # if~内容変更時パスワードの入力を省略させることが出来る
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  # nicknameは必須項目
  validates :nickname, presence: true
  # nameはTwitterでいうユーザーIDのようなもの。一意で必須項目。
  validates :name, uniqueness: true, presence: true
end
