require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    before do
      visit tasks_path
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'Name', with: 'task'
        fill_in 'Content', with: 'task'
        fill_in 'End time', with: Date.current
        select '着手中', from: 'Status'

        click_on '登録する'

        expect(page).to have_content 'task'
        expect(page).to have_content(Date.current)
      end
    end
  end
  describe '一覧表示機能' do
    before do
      FactoryBot.create(:user, name:'kimu',email:'kimu@kimu.com',password:'gaia0683',password_confirmation:'gaia0683')
      FactoryBot.create(:task, name:'task',content:'task',end_time:'2022-09-10',rank:'高',user: user)
      FactoryBot.create(:task, name: 'task2', content: 'task2',end_time:'2022-09-17',rank:'中',user: user)
      FactoryBot.create(:task, name: 'task3', content: 'task3',end_time:'2022-09-28',rank:'低',user: user)
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

        expect(task_list[0]).to have_content 'task3'
        expect(task_list[1]).to have_content 'task2'
      end
    end
    context 'タスクが優先度の高い順に並んでいる場合' do
      it '優先度の高いタスクが一番上に表示される' do
        click_on '優先度の高い順にソートする'

        sleep 1.0
        task_list = all('.task_list')

        expect(task_list[0]).to have_content '高'
        expect(task_list[1]).to have_content '中'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        FactoryBot.create(:user, name:'kimu',email:'kimu@kimu.com',password:'gaia0683',password_confirmation:'gaia0683')
        task = FactoryBot.create(:task, name: 'task', content: 'task',user: user)

        visit task_path(task.id)

        expect(page).to have_content 'task'
      end
    end
  end
  describe '検索機能' do
    before do
      FactoryBot.create(:task,name: "task",content:"task",status:"着手中")
      FactoryBot.create(:task,name:"task2",content:"task2",status:"完了")
      visit tasks_path
    end
    context "タイトルであいまい検索をした場合" do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'Name', with: 'task'

        click_on '検索する'

        expect(page).to have_content 'task'
      end
    end
    context "ステータス検索をした場合" do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        task_list = all('.task_list')
        select '着手中', from: 'task_status'

        click_on '検索する'

        expect(page).to have_selector 'td', text: '着手中'
      end
    end
    context "タイトルのあいまい検索とステータス検索をした場合" do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path

        task_list = all('.task_list')
        fill_in 'Name', with: 'task'
        select '着手中', from: 'task_status'

        click_on '検索する'

        expect(page).to have_content 'task'
        expect(page).to have_selector 'td', text: '着手中'
      end
    end
  end
end
