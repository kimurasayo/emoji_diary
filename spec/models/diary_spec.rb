require 'rails_helper'

RSpec.describe Diary, type: :model do
  describe 'validation' do
    it 'feelingが入力されていないと無効になる' do
      diary = build(:diary, feeling: nil)
      diary.valid?
      expect(diary.errors[:feeling]).to include("can't be blank")
    end

    it 'feelingに顔文字以外の文字が入力されていると無効になる' do
      diary = build(:diary, feeling: '💐')
      diary.valid?
      expect(diary.errors[:feeling]).to include("only emoji")
    end

    it 'feelingに2つ絵文字が入ると無効になる' do
      diary = build(:diary, feeling: '🤓😆')
      diary.valid?
      expect(diary.errors[:feeling]).to include("is too long (maximum is 1 character)")
    end

    it 'bodyに絵文字以外の文字が入力されるていると無効になる' do
      diary = build(:diary, body: '楽しかった〜')
      diary.valid?
      expect(diary.errors[:body]).to include("only emoji")
    end

    it 'bodyに20文字以上の絵文字が入力されると無効になる' do
      diary = build(:diary, body: '🦄🐇💐🕊🐼🐧🦴🐶🦢🐠🌷⛱🛍🧸🛋🪞🎨🩰🎺🏒🍫🍬🌈')
      diary.valid?
      expect(diary.errors[:body]).to include("is too long (maximum is 20 characters)")
    end

    it 'start_timeが入力されていないと無効になる' do
      diary = build(:diary, start_time: nil)
      diary.valid?
      expect(diary.errors[:start_time]).to include("can't be blank")
    end

    it 'start_timeが未来の日付だと無効になる' do
      diary = build(:diary, start_time: Date.tomorrow)
      diary.valid?
      expect(diary.errors[:start_time]).to include("can not specify your future date as date.")
    end

    it '全ての項目が有効である' do
      diary = build(:diary)
      expect(diary).to be_valid
    end
  end
end
