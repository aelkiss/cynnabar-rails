class AddSlugIndexToPages < ActiveRecord::Migration[4.2]
  def change
    add_index(:pages, :slug, unique: true)
  end
end
