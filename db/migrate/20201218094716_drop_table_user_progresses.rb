class DropTableUserProgresses < ActiveRecord::Migration[6.0]
  def up
    drop_table :user_progresses, if_exists: true
  end
end
