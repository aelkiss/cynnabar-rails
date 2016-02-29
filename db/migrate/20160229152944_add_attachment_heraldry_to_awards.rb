class AddAttachmentHeraldryToAwards < ActiveRecord::Migration
  def self.up
    change_table :awards do |t|
      t.attachment :heraldry
    end
  end

  def self.down
    remove_attachment :awards, :heraldry
  end
end
