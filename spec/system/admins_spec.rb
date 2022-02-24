require 'rails_helper'

RSpec.describe "Admins", type: :system do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  describe '管理画面' do
    it 'roleがadminなら管理画面を表示できる' do
      Login_as(admin)
      visit rails_admin_path
      expect(current_path).to eq rails_admin_path
    end

    it 'roleがgeneralなら管理画面を表示できない' do
      Login_as(user)
      visit rails_admin_path
      expect(current_path).to eq root_path
    end
  end
end
