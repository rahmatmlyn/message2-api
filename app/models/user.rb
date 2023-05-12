class User < ApplicationRecord
    has_secure_password
    # 
    has_many :conversations, foreign_key: 'sender_id'
    has_many :conversations, foreign_key: 'receiver_id'
    has_many :messages
    #memberikan validasi agar nama email dan password tidak boleh kosong
    validates_presence_of :name, :email, :password_digest
end
