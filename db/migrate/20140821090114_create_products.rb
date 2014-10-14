class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.integer :price
      t.string :button_color
      t.integer :position_number

      t.timestamps
    end
  end
end
