class ItemSerializer
    
    def initialize(item_object)
        @item = item_object
    end

    # def to_serialized_json
    #     @item.to_json(
    #         include: {
    #             :category => { Bakery },
    #             :sub_category => { Bread, Packaged }
    #         })
    # end

end