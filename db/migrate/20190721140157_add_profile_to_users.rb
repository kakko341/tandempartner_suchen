class AddProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :speak, :string
    add_column :users, :offer, :string
    add_column :users, :place, :string
    add_column :users, :age, :integer
  end
end
