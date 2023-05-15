class ConversationsController < ApplicationController
    # Sebelum melakukan aksi kita harus men set receiver terlebih dahulu, dan hannya bisa melihat saja dalam conversation ini
    before_action :set_receiver, only: [:show]


    def index
      # untuk melihat pesan terakhir dan keterangan di pesan tersebut seperti sudah dibaca atau belum
        conversations = Conversation.preload(:messages).show_conversations(@current_user.id)
        conversations.each do |conversation|
            # fitur 4.a last message
          conversation[:last_message] = conversation.messages.last
            # fitur 4.b unread message
          conversation[:unread] = unread_messages(conversation, @current_user.id).length
            end
        json_response(conversations)
    end

    # fitur untuk membuka conv, berdasarkan id user yang dituju
    def show
        conversation = Conversation.show_messages(@current_user.id, @receiver.id)
        # ketika membuka conv, conv akan diurutkan berdasarkan descending atau yang value terbesar berada diatas disini yang dimaksud adalah pesan terbaru
        messages = conversation.messages.order(created_at: :desc).page params[:page]

        # merubah table read menjadi true
        unread_messages = unread_messages(conversation, @current_user.id)
        unread_messages.update_all(read: true)
    
        json_response(messages)
    end

      private

        def set_receiver
            @receiver = User.find(params[:id])
        end

        def unread_messages(conversations, user_id)
            conversations.messages.where.not(user_id: user_id).where(read: false)
        end
    
end
