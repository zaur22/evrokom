class CreateMaterialsPrices < ActiveRecord::Migration
  def change
    create_table :materials_prices, id: false do |t|
      t.integer :material_id
      t.integer :price_id
    end
  end
end
