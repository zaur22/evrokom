class AddPriceColumnsToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :price, :string
  end
end
