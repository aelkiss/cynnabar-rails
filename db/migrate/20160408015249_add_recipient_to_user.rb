class AddRecipientToUser < ActiveRecord::Migration[4.2]
  def change
    add_reference :users, :recipient, index: true, foreign_key: true
  end
end
