require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'validation' do
    it 'ブックマークを同じ日記に２回すると無効になる' do
      user = create(:user)
      diary = create(:diary)
      create(:bookmark, user_id: user.id, diary_id: diary.id)
      bookmark = build(:bookmark, user_id: user.id, diary_id: diary.id)
      bookmark.valid?
      expect(bookmark.errors[:user_id]).to include("はすでに存在します")
    end

    it 'ブックマークは有効である' do
      bookmark = build(:bookmark)
      expect(bookmark).to be_valid
    end
  end
end
