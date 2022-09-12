require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザー登録のテスト' do
    context 'ユーザー登録のテスト' do
      it 'ユーザーを新規登録する' do
        visit new_user_path

        fill_in 'user_name', with: 'kimu'
        fill_in 'user_email', with: 'kimu@kimu.com'
        fill_in 'user_password', with: 'gaia0683'
        fill_in 'user_password_confirmation', with: 'gaia0683'

        click_on '自分のアカウントを新規登録する'

        expect(page).to have_selector 'p', text: 'kimu'
        expect(page).to have_selector 'p', text: 'kimu@kimu.com'
      end
      it 'ログインせずにタスク一覧画面に行こうとした時ログイン画面に遷移される'
    end
  end
end
