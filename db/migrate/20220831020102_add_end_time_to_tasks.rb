class AddEndTimeToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :end_time, :date, null: false, default: -> { '(CURRENT_DATE)' }
  end
end
