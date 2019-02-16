class CreateConditionDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_details do |t|
      t.string :name
      t.text :description
      t.string :color_code
      t.string :tags

      t.timestamps
    end
  end
end
