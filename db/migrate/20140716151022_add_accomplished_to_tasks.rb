class AddAccomplishedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :accomplished, :boolean, default: false
  end
end
