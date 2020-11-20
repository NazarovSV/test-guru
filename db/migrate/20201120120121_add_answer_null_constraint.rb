class AddAnswerNullConstraint < ActiveRecord::Migration[6.0]
  def change
    change_column_null :answers, :variant, false
    change_column_null :answers, :correct, false
  end
end
