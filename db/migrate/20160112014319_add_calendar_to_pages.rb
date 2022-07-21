class AddCalendarToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :calendar, :string
    add_column :pages, :calendar_title, :string
    add_column :pages, :calendar_details, :boolean
  end
end
