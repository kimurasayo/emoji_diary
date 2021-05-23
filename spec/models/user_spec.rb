require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'nicknameが入力されていないと無効になる' do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it 'user ID(nameカラム)が入力されていないと無効になる' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it '同じuser ID(nameカラム)は無効になる' do
      create(:user, name: 'name')
      user = build(:user, name: 'name')
      user.valid?
      expect(user.errors[:name]).to include("has already been taken")
    end

    it '違うuser ID(nameカラム)は有効である' do
      create(:user, name: 'name')
      user = build(:user, name: 'name1')
      user.valid?
    end

    it '全ての項目が有効である' do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end
