class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :body
      t.string :title
      t.string :slug

      t.timestamps null: false
    end
  end
end
