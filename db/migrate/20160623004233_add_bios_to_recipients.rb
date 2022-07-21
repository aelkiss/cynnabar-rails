class AddBiosToRecipients < ActiveRecord::Migration[4.2]
  def change
    add_column :recipients, :mundane_bio, :text, :limit => 4294967295
    add_column :recipients, :sca_bio, :text, :limit => 4294967295
    add_column :recipients, :activities, :text, :limit => 4294967295
    add_column :recipients, :food_prefs, :text, :limit => 4294967295
  end
end
