class User < ActiveRecord::Base
    has_many :stores
    has_secure_password
end
