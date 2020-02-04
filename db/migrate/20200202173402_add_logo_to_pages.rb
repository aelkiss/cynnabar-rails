class AddLogoToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :logo, :string
  end
end
