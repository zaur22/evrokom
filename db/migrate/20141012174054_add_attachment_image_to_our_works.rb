class AddAttachmentImageToOurWorks < ActiveRecord::Migration
  def self.up
    change_table :our_works do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :our_works, :image
  end
end
