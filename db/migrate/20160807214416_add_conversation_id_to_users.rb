class AddConversationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :conversation_id, :string
  end
end
