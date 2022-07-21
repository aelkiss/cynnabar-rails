class AddUserRefToPages < ActiveRecord::Migration[4.2]
  def change
    add_reference :pages, :user, index: true, foreign_key: true
  end
end
