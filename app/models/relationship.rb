class Relationship < ApplicationRecord
  # Followerクラスという存在しないクラスを参照することを防ぎ、Userクラスであることを明示。
  belongs_to :follower, class_name: 'User'
  belongs_to :user
end
