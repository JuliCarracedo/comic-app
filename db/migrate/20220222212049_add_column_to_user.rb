class AddColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string
  end

  add_index :users, :username, unique: true
end
