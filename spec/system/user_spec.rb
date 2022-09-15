require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do

  describe 'ユーザー登録のテスト' do
    context 'ユーザー登録に関する機能' do
      before do
        visit new_session_path
      end
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
      it 'ログインせずにタスク一覧画面に行こうとした時ログイン画面に遷移される' do
        visit tasks_path

        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能のテスト' do
    context 'ログインに関する機能' do
      before do
        visit new_session_path
      end
      it 'ログインができること' do
        FactoryBot.create(:user)

        fill_in 'session_email', with: 'kimu@kimu.com'
        fill_in 'session_password',	with: 'gaia0683'

        click_button 'ログイン'

        expect(page).to have_selector 'p', text: 'kimu'
        expect(page).to have_selector 'p', text: 'kimu@kimu.com'
      end
      it '自分の詳細画面に飛べること' do
        user = FactoryBot.create(:user)

        fill_in 'session_email', with: 'kimu@kimu.com'
        fill_in 'session_password',	with: 'gaia0683'

        click_button 'ログイン'

        expect(current_path).to eq user_path(user.id)
      end
      it '一般ユーザーが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
        user = FactoryBot.create(:user)
        second_user = FactoryBot.create(:second_user)

        fill_in 'session_email', with: 'kimu@kimu.com'
        fill_in 'session_password', with: 'gaia0683'

        click_button 'ログイン'

        visit user_path(second_user.id)

        expect(current_path).to eq tasks_path
      end
      it 'ログアウトができること' do
        user = FactoryBot.create(:user)

        fill_in 'session_email', with: 'kimu@kimu.com'
        fill_in 'session_password', with: 'gaia0683'

        click_button 'ログイン'

        click_link 'ログアウト'

        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理画面のテスト' do
    context '管理ユーザーに関する機能' do
      before do
        visit new_session_path
      end
      it '管理ユーザーは管理画面にアクセスできること' do
        user = FactoryBot.create(:third_user)

        fill_in 'session_email', with: 'kimubomute@kimubomute.com'
        fill_in 'session_password', with: 'gaia0683'

        click_button 'ログイン'

        visit admin_users_path

        expect(current_path).to eq admin_users_path
      end
      it '一般ユーザーは管理画面にアクセスできないこと' do
        user = FactoryBot.create(:user)

        fill_in 'session_email', with: 'kimu@kimu.com'
        fill_in 'session_password', with: 'gaia0683'

        click_button 'ログイン'

        visit admin_users_path

        expect(current_path).to eq tasks_path
      end
      it '管理ユーザーは新規登録ができること' do
        user = FactoryBot.create(:third_user)

        fill_in 'session_email', with: 'kimubomute@kimubomute.com'
        fill_in 'session_password', with: 'gaia0683'

        click_button 'ログイン'

        visit admin_users_path
        visit new_admin_user_path

        fill_in 'user_name', with: 'kimu'
        fill_in 'user_email', with: 'kimu@kimu.com'
        fill_in 'user_password', with: 'gaia0683'
        fill_in 'user_password_confirmation', with: 'gaia0683'

        click_on '自分のアカウントを新規登録する'

        expect(page).to have_selector 'td', text: 'kimu'
        expect(page).to have_selector 'td', text: 'kimu@kimu.com'
      end
      it '管理ユーザーはユーザーの詳細画面にアクセスできること' do
        user = FactoryBot.create(:third_user)
        second_user = FactoryBot.create(:user)

        fill_in 'session_email', with: 'kimubomute@kimubomute.com'
        fill_in 'session_password', with: 'gaia0683'

        click_button 'ログイン'

        visit admin_users_path
        visit admin_user_path(second_user.id)

        expect(current_path).to eq admin_user_path(second_user.id)
      end
      it '管理ユーザーはユーザーの編集画面からユーザーを編集できること' do
        user = FactoryBot.create(:third_user)
        second_user = FactoryBot.create(:user)

        fill_in 'session_email', with: 'kimubomute@kimubomute.com'
        fill_in 'session_password', with: 'gaia0683'

        click_button 'ログイン'

        visit admin_users_path

        expect(page).to have_selector 'td', text: 'kimu'
        expect(page).to have_selector 'td', text: 'kimu'

        visit edit_admin_user_path(second_user.id)

        fill_in 'user_name', with: 'bomu'
        fill_in 'user_email', with: 'bomu@bomu.com'
        fill_in 'user_password',	with: 'gaia0683'
        fill_in 'user_password_confirmation', with: 'gaia0683'

        click_on 'アカウントを更新する'

        expect(page).to have_selector 'td', text: 'bomu'
        expect(page).to have_selector 'td', text: 'bomu@bomu.com'
      end
      it '管理ユーザーはユーザーの削除をできること' do
        user = FactoryBot.create(:third_user)
        second_user = FactoryBot.create(:user)

        fill_in 'session_email', with: 'kimubomute@kimubomute.com'
        fill_in 'session_password', with: 'gaia0683'

        click_button 'ログイン'

        visit admin_users_path
        expect(page).to have_content 'kimu@kimu.com'

        delete = User.find_by(name: 'kimu')
        click_link 'ユーザーを削除する', href: admin_user_path(delete)

        expect(page).to_not have_content 'kimu@kimu.com'
      end
    end
  end
end
