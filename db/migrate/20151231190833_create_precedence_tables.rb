class CreatePrecedenceTables < ActiveRecord::Migration[4.2]
  def change
    create_table :awards do |t|
      t.string :name
      t.string :description
      t.integer :precedence

      t.timestamps
    end

    create_table :recipients do |t|
      t.string :sca_name
      t.string :mundane_name
      t.boolean :is_group

      t.timestamps
    end

    create_table :awardings do |t|
      t.references :award, index: true
      t.references :recipient, index: true
      t.date :received

      t.timestamps
    end

    create_table :groups do |t|
      t.string :name

      t.timestamps
    end

    add_reference :awards, :group, index: true

    add_column :recipients, :also_known_as, :string
    add_column :recipients, :formerly_known_as, :string

    add_reference :awardings, :group, index: true
    add_column :awardings, :award_name, :string
    add_column :awards, :other_award, :boolean
  end
end
