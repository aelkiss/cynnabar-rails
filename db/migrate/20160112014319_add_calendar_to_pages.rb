class AddCalendarToPages < ActiveRecord::Migration
  def change
    add_column :pages, :calendar, :string
    add_column :pages, :calendar_title, :string
    add_column :pages, :calendar_details, :boolean
  end
end
