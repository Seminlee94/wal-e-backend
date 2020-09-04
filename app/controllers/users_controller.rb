class UsersController < ApplicationController

    def index
        users = User.all
        render json: UserSerializer.new(users).to_serialized_json
    end

    def show
        user = User.find(params[:id])
        render json: UserSerializer.new(user).to_serialized_json
    end
    
    def create
        user = User.new(user_params)
        render json: user
    end
        
    def update
        user = User.find(params[:id])
        user.update(user_params)
        render json: user
    end
    
    def delete
        user = User.find(params[:id])
        user.destroy
        render json: {}
    end
    
    private
    
    def user_params
        params.require(:user).permit(:name, :username, :password)
    end
end
