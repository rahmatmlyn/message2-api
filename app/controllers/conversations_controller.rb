class ConversationsController < ApplicationController
    # Sebelum masuk kedalam conversation user harus login/authenticate dahulu dan hanya bisa melihat conversation saja
    before_action :set_receiver, only: [:show]


    def index
        conversations = Conversation.preload(:messages).show_conversations(@current_user.id)
        conversations.each do |conversation|
            # fitur 4.a last message
          conversation[:last_message] = conversation.messages.last
            # fitur 4.b unread message
          conversation[:unread] = unread_messages(conversation, @current_user.id).length
            end
        json_response(conversation)
    end


    def show
        conversation = Conversation.show_messages(@current_user.id, @receiver.id)
    
        messages = conversation.messages.order(created_at: :desc).page params[:page]
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
