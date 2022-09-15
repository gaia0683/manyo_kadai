require 'rails_helper'
  describe 'タスクモデル機能', type: :model do
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルがからの場合' do
        it 'バリデーションに引っ掛かる' do
          task = Task.new(name: '', content: '失敗テスト')
          expect(task).not_to be_valid
  end
end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションに引っ掛かる' do
        task = Task.new(name: 'task', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        user = FactoryBot.create(:user,name:'kimu',email:'kimu@kimu.com')
        task = FactoryBot.create(:task,name: 'task', content: 'task',user_id: user.id)
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:user){ FactoryBot.create(:user, name:'kimu',email:'kimu@kimu.com') }
    let!(:task){ FactoryBot.create(:task, name:'task',content:'aa',status:'着手中',user:user) }
    let!(:second_task){ FactoryBot.create(:task, name:'sample',content:'bb',status:'完了',user:user) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it '検索キーワードを含むタスクが絞り込まれる' do
        expect(Task.search_name('task')).to include(task)
        expect(Task.search_name('task')).not_to include(second_task)
        expect(Task.search_name('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.search_status('着手中')).to include(task)
        expect(Task.search_status('着手中')).not_to include(second_task)
        expect(Task.search_status('着手中').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
      expect(Task.search('task','着手中')).to include(task)
      expect(Task.search('task','着手中')).not_to include(second_task)
      expect(Task.search('task','着手中').count).to eq 1
      end
    end
  end
end
