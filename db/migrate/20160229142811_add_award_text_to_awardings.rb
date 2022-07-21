class AddAwardTextToAwardings < ActiveRecord::Migration[4.2]
  def change
    add_column :awardings, :award_text, :text, :limit => 4294967295
  end
end
