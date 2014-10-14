class CreateMaterialsProducts < ActiveRecord::Migration
  def change
    create_table :materials_products, id: false do |t|
	t.integer :material_id
	t.integer :product_id
    end
  end
end
