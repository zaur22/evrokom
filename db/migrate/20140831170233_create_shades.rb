class CreateShades < ActiveRecord::Migration
  def change
    create_table :shades do |t|
      t.string :color
      t.string :name

      t.timestamps
    end
  end
end
