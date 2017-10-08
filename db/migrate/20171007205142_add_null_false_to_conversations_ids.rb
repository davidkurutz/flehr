class AddNullFalseToConversationsIds < ActiveRecord::Migration[5.1]
  def change
    change_column_null :conversations, :sender_id, false
    change_column_null :conversations, :recipient_id, false
  end
end
