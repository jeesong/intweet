class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    # add index to the email column of the users table
    add_index :users, :email, unique: true
  end
end
