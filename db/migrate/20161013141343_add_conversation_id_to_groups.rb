class AddConversationIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :conversation_id, :string
  end
end
