class AddRecipientToUser < ActiveRecord::Migration
  def change
    add_reference :users, :recipient, index: true, foreign_key: true
  end
end
