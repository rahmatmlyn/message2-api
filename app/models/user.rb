class User < ApplicationRecord
    has_secure_password
    #memberikan validasi agar nama email dan password tidak boleh kosong
    validates_presence_of :name, :email, :password_digest
end
