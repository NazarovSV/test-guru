class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.string :name
      t.string :image_url
      t.string :rule_type
      t.string :description

      t.timestamps
    end
  end
end
