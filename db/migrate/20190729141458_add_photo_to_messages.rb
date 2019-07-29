class AddPhotoToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :photo, :string
  end
end
