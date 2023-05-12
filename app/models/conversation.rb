class Conversation < ApplicationRecord
    belongs_to :sender, class_name: "User", foreign_key: "sender_id"
    belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

    has_many :messages

    scope :show_conversations, lambda { |sender_id|
        where ('sender_id = ? OR recipient_id = ?', sender_id, sender_id).order(updated_at: :desc)
      }
  end