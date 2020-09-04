class CartsController < ApplicationController

    def index
        carts = Cart.all

        render json: CartSerializer.new(carts).to_serialized_json
    end

    def show
        cart = Cart.find(params[:id])
        render json: CartSerializer.new(cart).to_serialized_json
    end
    
    def update
        cart = Cart.find(params[:id])
        cart.update(cart_params)
        render json: cart
    end
    
    private
    
    def cart_params
        params.require(:cart).permit(:user_id)
    end

end
