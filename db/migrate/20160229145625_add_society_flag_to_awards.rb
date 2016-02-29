class AddSocietyFlagToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :society, :boolean, null: false, default: false
  end
end
