require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'iconの絵文字が入力されていないと無効になる' do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it 'user nameが入力されていないと無効になる' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("入力必須項目です")
    end

    it 'user nameに半角英数字以外が入力されると無効になる' do
      user = build(:user, name: 'name_1')
      user.valid?
      expect(user.errors[:name]).to include("半角英数字のみ使用できます")
    end

    it '同じuser nameは無効になる' do
      create(:user, name: 'name')
      user = build(:user, name: 'name')
      user.valid?
      expect(user.errors[:name]).to include("既に存在するユーザー名です")
    end

    it '違うuser nameは有効である' do
      create(:user, name: 'name')
      user = build(:user, name: 'name1')
      expect(user).to be_valid
    end

    it 'user nameは15文字以上だと無効になる' do
      user = build(:user, name: 'nagasugirunamedayo')
      user.valid?
      expect(user.errors[:name]).to include("15文字以内で入力してください")
    end

    it 'パスワードが違うと無効になる' do
      user = build(:user, password: 'password', password_confirmation: 'password1')
      user.valid?
      expect(user.errors[:password_confirmation]).to include("パスワードが一致しません")
    end

    it 'パスワードが短いと無効になる' do
      user = build(:user, password: 'pass', password_confirmation: 'pass')
      user.valid?
      expect(user.errors[:password]).to include("8文字以上入力してください")
    end

    it 'emailの形式がおかしいと無効になる' do
      user = build(:user, email: 'email.com')
      user.valid?
      expect(user.errors[:email]).to include("正しいメールアドレスを入力してください")
    end

    it '同じemailは無効になる' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      user.valid?
      expect(user.errors[:email]).to include("既に存在するメールアドレスです")
    end

    it '全ての項目が有効である' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end
  end
end
