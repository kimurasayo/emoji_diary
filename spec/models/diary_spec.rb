require 'rails_helper'

RSpec.describe Diary, type: :model do
  describe 'validation' do
    it 'feelingが入力されていないと無効になる' do
      diary = build(:diary, feeling: nil)
      diary.valid?
      expect(diary.errors[:feeling]).to include("入力必須項目です")
    end

    it 'bodyに絵文字以外の文字が入力されるていると無効になる' do
      diary = build(:diary, body: '楽しかった〜')
      diary.valid?
      expect(diary.errors[:body]).to include("絵文字以外の文字は入力できません")
    end

    it 'start_timeが入力されていないと無効になる' do
      diary = build(:diary, start_time: nil)
      diary.valid?
      expect(diary.errors[:start_time]).to include("入力必須項目です")
    end

    it 'start_timeが未来の日付だと無効になる' do
      diary = build(:diary, start_time: Date.tomorrow)
      diary.valid?
      expect(diary.errors[:start_time]).to include("未来の日付は入力できません")
    end

    it '同じstart_timeの日記は無効になる' do
      user = create(:user)
      create(:diary, user_id: user.id, start_time: Date.today)
      diary = build(:diary, user_id: user.id, start_time: Date.today)
      diary.valid?
      expect(diary.errors[:start_time]).to include("設定した日付の日記は既に存在しています")
    end

    it '全ての項目が有効である' do
      diary = build(:diary)
      expect(diary).to be_valid
    end
  end
end
