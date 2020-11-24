class CreateUserProgresses < ActiveRecord::Migration[6.0]
  def change
    create_table :user_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.integer :total_passed_questions, null: false, default: 0
      t.boolean :is_completed, null: false, default: false

      t.timestamps
    end
  end
end
