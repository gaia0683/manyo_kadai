require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, name:'task', content:'task') }
  describe '新規作成機能' do
    before do
      visit tasks_path
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'Name', with: 'task'
        fill_in 'Content', with: 'task'

        click_on '登録する'

        expect(page).to have_content 'task'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      FactoryBot.create(:task, name: 'task2', content: 'task2')
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do


        task_list = all('.task_list')
        binding.irb

        expect(task_list[0]).to have_content 'task2'
        expect(task_list[1]).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do

        task = FactoryBot.create(:task, name: 'task', content: 'task')

        visit task_path(task.id)

        expect(page).to have_content 'task'
      end
    end
  end
end
