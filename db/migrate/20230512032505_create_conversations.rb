class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.foreign_key :users, column: :sender_id, on_delete: :nullify
      t.foreign_key :users, column: :receiver_id, on_delete: :nullify
      t.timestamps
    end
  end
end
