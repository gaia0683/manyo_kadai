require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  describe 'タスクにラベルをつけて管理できる' do
    context 'タスクにラベルをつけることに関する機能' do
      before do
        FactoryBot.create(:user)
        FactoryBot.create(:label)
        FactoryBot.create(:second_label)

        visit new_session_path

        fill_in 'session_email', with: 'kimu@kimu.com'
        fill_in 'session_password',	with: 'gaia0683'

        click_button 'ログイン'
        visit new_task_path
        fill_in 'task_name', with: 'abc'
        fill_in 'task_content', with: 'abc'
      end
      it 'ラベルをタスクに複数つけられるようにすること' do
        check '仕事'
        check '遊び'

        expect(page).to have_checked_field('仕事')
        expect(page).to have_checked_field('遊び')
      end
      it 'ラベルがタスクを新規作成する際にタスクと一緒に登録できること' do
        check '仕事'
        check '遊び'

        click_button '登録する'

        expect(page).to have_content '仕事'
        expect(page).to have_content '遊び'
      end
      it 'タスクの詳細ページでタスクに紐付いているラベル一覧が表示されること' do
        check '仕事'
        check '遊び'

        click_button '登録する'

        expect(page).to have_selector 'p', text: '仕事'
        expect(page).to have_selector 'p', text: '遊び'
      end
      it 'タスクを編集する際にラベルも編集できること' do
        check '仕事'
        check '遊び'

        click_button '登録する'

        visit edit_task_path(Task.first)

        uncheck '仕事'
        uncheck '遊び'

        click_button '登録する'

        expect(page).not_to have_selector 'p', text: '仕事'
        expect(page).not_to have_selector 'p', text: '遊び'
      end
      it 'タスクの詳細画面でそのタスクに紐付いてるラベル一覧を出力できること' do
        check '仕事'
        check '遊び'

        click_button '登録する'

        expect(page).to have_selector 'p', text: '仕事'
        expect(page).to have_selector 'p', text: '遊び'
      end
    end
    context 'ラベルでタスクを検索することに関する機能' do
      before do
        FactoryBot.create(:user)
        FactoryBot.create(:label)
        FactoryBot.create(:second_label)

        visit new_session_path

        fill_in 'session_email', with: 'kimu@kimu.com'
        fill_in 'session_password',	with: 'gaia0683'

        click_button 'ログイン'
        visit new_task_path
        fill_in 'task_name', with: 'abc'
        fill_in 'task_content', with: 'abc'
      end
      it 'タスク一覧ページでラベルでタスク検索ができる' do
        check '仕事'
        check '遊び'

        click_button '登録する'


        visit tasks_path
        save_and_open_page
        select '仕事', from: 'task_label_id'

        click_button '検索する'

        expect(page).to have_selector 'td', text: 'abc'
        expect(page).to have_selector 'td', text: 'abc'
      end
    end
  end
end
