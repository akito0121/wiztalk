class User < ApplicationRecord
    validates :name,presence: true ,uniqueness: true
    validates :password, presence: true
    
    has_many :posts, dependent: :destroy
end
