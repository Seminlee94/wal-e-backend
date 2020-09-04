class CartSerializer

    def initialize(cart_object)
        @cart = cart_object
    end

    def to_serialized_json
        @cart.to_json(
            include: {
                item: {
                    except: [:created_at, :updated_at]
                },
                user: {
                    except: [:password, :created_at, :updated_at]
                }
            }
        )
    end

end