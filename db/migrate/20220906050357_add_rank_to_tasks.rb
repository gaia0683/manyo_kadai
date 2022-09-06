class AddRankToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :rank, :integer, null: false,
    default: '0'
  end
end
