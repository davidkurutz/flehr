class AddNullFalseToMessagesForeignKeys < ActiveRecord::Migration[5.1]
  def change
    change_column_null :messages, :conversation_id, false
    change_column_null :messages, :sender_id, false
  end
end
