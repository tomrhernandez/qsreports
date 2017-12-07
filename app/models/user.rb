class User < ActiveRecord::Base
    #has_many :stores
    has_and_belongs_to_many :stores
    has_secure_password
end
