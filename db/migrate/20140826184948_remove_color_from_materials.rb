class RemoveColorFromMaterials < ActiveRecord::Migration
  def change
    remove_column :materials, :color, :integer
  end
end
