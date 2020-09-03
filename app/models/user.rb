class User < ApplicationRecord
    has_many :carts
    has_many :items, through: :carts
    # validates :name, presence: true
    # validates :username, presence: true, uniqueness: true
    # validates :password, presence: true


end
