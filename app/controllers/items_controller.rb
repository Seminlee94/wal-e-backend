class ItemsController < ApplicationController
    
    def index
        items = Item.all

        render json: items, except: [:created_at, :updated_at]
    end
    
    def show
        item = Item.find(params[:id])
        render json: item, except: [:created_at, :updated_at]
    end
    
    def update
        item = Item.find(params[:id])
        render json: item, except: [:created_at, :updated_at]
    end
    
    private
    
    def item_params
        params.require(:item).permit(:item_id, :name, :sales_price, :description, :inventory_quantity, :image, :nutrition)
    end

end
