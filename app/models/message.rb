class Message < ApplicationRecord
    paginates_per 20
    belongs_to :conversation
    belongs_to :user

    validates_presence_of :body
end
