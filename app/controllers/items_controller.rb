class ItemsController < ApplicationController
    
    def index
        items = Item.all

        render json: items, except: [:created_at, :updated_at]
    end
    
    def show
        item = Item.find(params[:id])
        render json: item, except: [:created_at, :updated_at]
    end

    def create
        item = Item.search(params[:name])
        # binding.pry
        render json: item, except: [:created_at, :updated_at]
    end
    
    def update
        item = Item.find(params[:id])
        item.update(item_params)
        render json: item, except: [:created_at, :updated_at]
    end

    def delete
        item = Item.find(params[:id])

        render json: {}
    end
    
    private
    
    def item_params
        params.require(:item).permit(:item_id, :name, :sales_price, :description, :receipt_info, :inventory_quantity, :image, :nutrition, :category, :sub_category, :quantity)
    end

end