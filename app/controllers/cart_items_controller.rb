class CartItemsController < ApplicationController
    
    def index
        cart_items = CartItem.all
        render json: CartItemSerializer.new(cart_items).to_serialized_json
    end
    
    def show
        cart_item = CartItem.find(params[:id])
        render json: CartItemSerializer.new(cart_item).to_serialized_json
    end
    
    def create
        cart_item = CartItem.create(cart_item_params)
        render json: cart_item
    end

    def update
        cart_item = CartItem.find(params[:id])
        
    end
    
    def destory
        cart_item = CartItem.find(params[:id])
        cart_item.destroy
    
        render json: {}
    end
    
    private
    
    def cart_item_params
        params.require(:cart_item).permit(:cart_id, :item_id)
    end
    
    

end
