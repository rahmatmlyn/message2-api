class User < ApplicationRecord

    #memberikan validasi agar nama email dan password tidak boleh kosong
    validates_presence_of :name, :email, :password_digest
end
