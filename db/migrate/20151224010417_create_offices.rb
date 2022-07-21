class CreateOffices < ActiveRecord::Migration[4.2]
  def change
    create_table :offices do |t|
      t.string :name
      t.string :email
      t.string :image
      t.references :page, index: true, foreign_key: true
      t.references :officer, index: true 

      t.timestamps null: false
    end
    add_foreign_key :offices, :users, column: :officer_id
  end
end
