class SetNotNullOnGuid < ActiveRecord::Migration[5.1]
  def change
    change_column_null :conversations, :guid, false
  end
end
