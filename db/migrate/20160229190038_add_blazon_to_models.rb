class AddBlazonToModels < ActiveRecord::Migration[4.2]
  def change
    add_column :recipients, :heraldry_blazon, :text, :limit => 65536
    add_column :awards, :heraldry_blazon, :text, :limit => 65536
  end
end
