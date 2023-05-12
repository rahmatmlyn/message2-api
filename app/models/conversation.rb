class Conversation < ApplicationRecord
    belongs_to :user, foreign_key: 'sender_id', class_name: 'User'
    belongs_to :user, foreign_key: 'receiver_id', class_name: 'User'

    has_many :messages
    attribute :last_message
    attribute :unread

    scope :show_conversations, lambda { |sender_id|
        where ('sender_id = ? OR receiver_id = ?', sender_id, sender_id).order(updated_at: :desc)
      }

      def self.show_messages(sender_id, receiver_id)
        where('(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)',
              sender_id, receiver_id, receiver_id, sender_id).first
      end
  end