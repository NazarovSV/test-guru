class AddTestLevelConstraint < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tests, :level, false
    change_column_default :tests, :level, false
  end
end
