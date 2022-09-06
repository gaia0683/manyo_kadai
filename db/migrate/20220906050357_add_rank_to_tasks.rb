class AddRankToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :rank, :string, null: false,
    default: '低'
  end
end
