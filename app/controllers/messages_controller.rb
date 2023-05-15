class MessagesController < ApplicationController

    
    def create
        
        conversation = Conversation.show_messages(@current_user.id, params[:receiver_id])
        
        # jika conversation tidak ada maka controller akan membuatnya
        if conversation.nil?
          conversation = Conversation.create!(sender_id: @current_user.id, receiver_id: params[:receiver_id])
        end
        
        # Create message
        message = Message.create!(user_id: @current_user.id, conversation_id: conversation.id, body: params[:body])
    
        conversation.update!(updated_at: message.created_at)
        json_response(message)
      end
end
