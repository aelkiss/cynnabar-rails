class AddSlugIndexToPages < ActiveRecord::Migration
  def change
    add_index(:pages, :slug, unique: true)
  end
end
