class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :name
      t.string :email
      t.string :image
      t.references :page, index: true, foreign_key: true
      t.references :officer, references: :users, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
