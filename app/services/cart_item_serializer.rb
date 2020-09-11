class CartItemSerializer
    
    def initialize(cart_item_obj)
        @cart_item_obj = cart_item_obj
        # binding.pry
    end

    def to_serialized_json
        @cart_item_obj.to_json(
            :include => {
                :item => {
                    :except => [:created_at, :updated_at]
                }
            }
        )
    end

end