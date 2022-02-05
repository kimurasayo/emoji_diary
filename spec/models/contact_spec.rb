require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validation' do
    it 'nameが入力されていないと無効になる' do
      contact = build(:contact, name: nil)
      contact.valid?
      expect(contact.errors[:name]).to include("入力必須項目です")
    end

    it 'emailが入力されていないと無効になる' do
      contact = build(:contact, email: nil)
      contact.valid?
      expect(contact.errors[:email]).to include("入力必須項目です")
    end

    it 'contentが入力されていないと無効になる' do
      contact = build(:contact, content: nil)
      contact.valid?
      expect(contact.errors[:content]).to include("入力必須項目です")
    end

    it '全て入力されていると有効になる' do
      contact = build(:contact)
      expect(contact).to be_valid
    end
  end
end
