class AddAttachmentHeraldryToRecipients < ActiveRecord::Migration[4.2]
  def self.up
    change_table :recipients do |t|
      t.attachment :heraldry
    end
  end

  def self.down
    remove_attachment :recipients, :heraldry
  end
end
