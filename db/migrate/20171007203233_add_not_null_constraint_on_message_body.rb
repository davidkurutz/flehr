class AddNotNullConstraintOnMessageBody < ActiveRecord::Migration[5.1]
  def change
    change_column_null :messages, :body, false
  end
end
