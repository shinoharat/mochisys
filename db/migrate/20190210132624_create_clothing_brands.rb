class CreateClothingBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :clothing_brands do |t|
      t.string :ja_name
      t.string :en_name
      t.text :description

      t.timestamps
    end
  end
end
