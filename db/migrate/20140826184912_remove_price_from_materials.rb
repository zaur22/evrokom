class RemovePriceFromMaterials < ActiveRecord::Migration
  def change
    remove_column :materials, :price, :integer
  end
end
