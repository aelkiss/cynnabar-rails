class AddSocietyFlagToAwards < ActiveRecord::Migration[4.2]
  def change
    add_column :awards, :society, :boolean, null: false, default: false
  end
end
