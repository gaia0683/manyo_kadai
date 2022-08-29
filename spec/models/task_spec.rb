require 'rails_helper'
  describe 'タスクモデル機能', type: :model do
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルがからの場合' do
        it 'バリデーションに引っ掛かる' do
          task = Task.new(name: '', content: '失敗テスト')
          expect(task).not_to be_valid
  end
end
    context 'タスクの詳細がからの場合' do
      it 'バリデーションに引っ掛かる' do
        task = Task.new(name: 'task', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: 'task', content: 'task')
        expect(task).to be_valid
      end
    end
  end
end
