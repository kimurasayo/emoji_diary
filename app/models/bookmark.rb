class Bookmark < ApplicationRecord
  # モデルの作成時にuser:referencesをつけたのでデフォルトで書いてある
  belongs_to :user
  # モデルの作成時にdiary:referencesをつけたのでデフォルトで書いてある
  belongs_to :diary

  # user_idに対してdiary_idは一意な関係である
  validates :user_id, uniqueness: { scope: :diary_id }
end
