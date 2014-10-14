class CreateMaterialsShades < ActiveRecord::Migration
  def change
    create_table :materials_shades, id: false do |t|
      t.integer :material_id
      t.integer :shade_id
    end
  end
end
