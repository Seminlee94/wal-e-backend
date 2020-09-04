class ItemsController < ApplicationController
    
    def index
        items = Item.all
    end
    
    def show
        item = Item.find(params[:id])
    end
    
    def update
        item = Item.find(params[:id])
        # redirect_to item_path(@item)
    end
    
    def delete
        item = Item.find(params[:id])
        @item.destroy
    
        # redirect_to items_path
    end
    
    private
        
    def find_item
        @item = Item.find(params[:id])
    end
    
    def item_params
        params.require(:item).permit('fields')
    end
    
    

end
