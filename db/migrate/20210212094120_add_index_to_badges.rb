class AddIndexToBadges < ActiveRecord::Migration[6.0]
  def change
    add_index :badges, %i[name image_url rule_type], unique: true
  end
end
