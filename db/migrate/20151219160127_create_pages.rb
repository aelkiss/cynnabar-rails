class CreatePages < ActiveRecord::Migration[4.2]
  def change
    create_table :pages do |t|
      t.text :body, :limit => 4294967295
      t.string :title
      t.string :slug

      t.timestamps null: false
    end
  end
end
