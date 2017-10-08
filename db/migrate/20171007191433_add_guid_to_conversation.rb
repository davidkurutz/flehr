class AddGuidToConversation < ActiveRecord::Migration[5.1]
  def change
    add_column :conversations, :guid, :string
    add_index :conversations, :guid, unique: true
  end
end
