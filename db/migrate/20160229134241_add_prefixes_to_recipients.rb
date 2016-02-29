class AddPrefixesToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :title, :string
    add_column :recipients, :pronouns, :string
  end
end
