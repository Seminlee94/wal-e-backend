class User < ApplicationRecord
    has_one :cart
    has_many :items, through: :cart

    # validates :name, presence: true
    # validates :username, presence: true, uniqueness: true
    # validates :password, presence: true

end
