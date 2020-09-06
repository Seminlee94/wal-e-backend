# require 'pry'
# require 'json'
# require "uri"
# require "net/http"
# require "dotenv"
# require "rest-client"
# # require_relative "./item.rb"
# # require "httparty"
# Dotenv.load


# class GroceryInfo

#     @@base_url = "https://api.wegmans.io/products/"
#     @@key = ENV["WEGMAN_API_KEY"]

#     def self.category
#         response = RestClient.get("https://api.wegmans.io/products/categories?api-version=2018-10-18", headers={'Subscription-Key': @@key}){|response, request, result| response }
#         result = JSON.parse(response.body)
#         return result["categories"].collect do |category|
#             # category["name"]
#             category["id"]
#         end
#         # if we want category class - .each  key=["name"]
#     end

#     def self.sub_category
#         GroceryInfo.category.collect do |id| 
#             response = RestClient.get("https://api.wegmans.io/products/categories/#{id}?api-version=2018-10-18", headers={'Subscription-Key': @@key}){|response, request, result| response }
#             result = JSON.parse(response.body)
#             return result["categories"].collect do |sub_category|
#                 sub_category["id"]
#             end
#         end 
#     end

#     def self.item_by_category
#         GroceryInfo.sub_category.collect do |sub_id|
#             response = RestClient.get("https://api.wegmans.io/products/categories/#{sub_id}?api-version=2018-10-18", headers={'Subscription-Key': @@key}){|response, request, result| response }
#             result = JSON.parse(response.body)
#             return result["products"].collect do |product|
#                 product["sku"]
#             end
#         end
#     end

#     def self.info
#         skus = GroceryInfo.item_by_category.sample(40)

#         return skus.collect do |sku|
#             response = RestClient.get("https://api.wegmans.io/products/#{sku}?api-version=2018-10-18", headers={'Subscription-Key': @@key}){|response, request, result| response }
#             result = JSON.parse(response.body)
#             # binding.pry
#         end
#     end

#     def self.create_item
#         items = GroceryInfo.info

#         items.each do |item|
#             response = RestClient.get("https://api.wegmans.io/products/#{item["sku"]}/prices?api-version=2018-10-18", headers={'Subscription-Key': @@key}){|response, request, result| response }
#             # response = RestClient.get("https://api.wegmans.io/products/756507/prices?api-version=2018-10-18", headers={'Subscription-Key': @@key}){|response, request, result| response }
#             result = JSON.parse(response.body)
#             price = result["stores"][0]["price"]
#             # binding.pry
#             Item.populate(item, price)
        # Item.find_or_create_by(
        #     item_id: item["sku"], #sku number - product_url
        #     name: item["name"], #product_url
        #     sales_price: price, #price_url
        #     description: item["descriptions"]["consumer"],
        #     receipt_info: item["descriptions"]["receipt"],
        #     inventory_quantity: rand(50..100),
        #     image: item["tradeIdentifiers"][0]["images"][0],
        #     nutrition: item["nutrition"][0]["description"]
        # )
    #     end
    # end

    # def self.data(item_name)
    #     #list_url = URI("https://api.wegmans.io/products/search?query=#{item_name}&api-version=2018-10-18&") # item names (need to collect SKU)
    #     #url = URI("https://api.wegmans.io/products/categories/6942-577-583?api-version=2018-10-18") # returns all products based on item name

    #     product_url = URI("https://api.wegmans.io/products/categories/561-562?api-version=2018-10-18&subscription-key=#{ENV["WEGMAN_API_KEY"]}") #returns all items based on sub-category

    #     price_url = URI("https://api.wegmans.io/products/756505/prices?api-version=2018-10-18") # prices (interpolate SKU here)
    #     info_url = URI("https://api.wegmans.io/products/756507?api-version=2018-10-18") # info - description & nutrients (interpolate SKU here)
        
    #     https = Net::HTTP.new(product_url.host, product_url.port);
    #     https.use_ssl = true
        
    #     request = Net::HTTP::Get.new(product_url)
    #     request["Subscription-Key"] = ENV["WEGMAN_API_KEY"]
        
        
    #     response = https.request(request)
    #     data = response.read_body
        
    #     parse = JSON.parse(data)
        
    #     price = parse["products"].each do |product|
    #         # binding.pry
    #         price_url = URI("https://api.wegmans.io/products/#{product["sku"]}/prices?api-version=2018-10-18") # prices (interpolate SKU here)
    #         # info_url = URI("https://api.wegmans.io/products/#{product["sku"]}?api-version=2018-10-18")
    #         binding.pry
            
    #     end
        
        # binding.pry
        # info = parse["products"].each do |product|
            
        # end

        # Item.create(
        #     item_id: , #sku number - product_url
        #     name: , #product_url
        #     sales_price: , #price_url
        #     description: ,
        #     inventory_quantity: ,
        #     image: ,
        #     nutrition: 
        # )

        #* (:item_id, :name, :sales_price, :description, :inventory_quantity, :image, :nutrition)

        # binding.pry
        # 0
# end

# GroceryInfo.data("milk")
# GroceryInfo.category
# GroceryInfo.sub_category
# GroceryInfo.item_by_category
# GroceryInfo.info
# GroceryInfo.create_item

# puts "works"