class AddPrefixesToRecipients < ActiveRecord::Migration[4.2]
  def change
    add_column :recipients, :title, :string
    add_column :recipients, :pronouns, :string
  end
end
