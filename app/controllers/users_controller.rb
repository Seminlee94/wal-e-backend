class UsersController < ApplicationController

    def index
        users = User.all

        # render json: users, except: [:password]
        render json: UserSerializer.new(users).to_serialized_json
    end

    def show
        user = User.find(params[:id])

        render json: user, except: [:password]
    end

end
