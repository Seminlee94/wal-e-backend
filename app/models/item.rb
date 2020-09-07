require 'pry'
require 'json'
# require "uri"
# require "net/http"
require "dotenv"
require "rest-client"
# require_relative "./item.rb"
require "httparty"
Dotenv.load

# TODO - I think the next step would be to create an additional method that if the subcategory has 0 products it will go to Item.sub_sub_category passing the sub_category id
# TODO  - and then in that sub_sub_category, we can do a .each if the products number is > 0 and then pass in that product’s sku to the Item.info method




class Item < ApplicationRecord
# class Item < ActiveRecord::Base
    has_many :cart_items
    has_many :carts, through: :cart_items

    # @@key = ENV["WEGMAN_API_KEY"]
    # binding.pry
    @@key = ENV["WEGMAN_API_KEY"]

    def self.category
        # response = RestClient.get("https://api.wegmans.io/products/categories?api-version=2018-10-18", headers={'Subscription-Key': key}){|response, request, result| response }
        response = HTTParty.get("https://api.wegmans.io/products/categories?api-version=2018-10-18&subscription-key=#{@@key}") #{|response, request, result| response }
        result = JSON.parse(response.body)
        return result["categories"].each do |category|
            # category["name"]
            puts "#{category["id"]} - #{category["name"]}"
            Item.sub_category(category["id"])
        end
        # if we want category class - .each  key=["name"]
    end
    
    def self.sub_category(id)
        # Item.category.collect do |id| 
        response = HTTParty.get("https://api.wegmans.io/products/categories/#{id}?api-version=2018-10-18&subscription-key=#{@@key}") #{|response, request, result| response }
        result = JSON.parse(response.body)
        result["categories"].each do |sub_category|
            
            puts "#{sub_category["id"]} - #{sub_category["name"]}"
            
            # if sub_category["id"]
                Item.item_by_category(sub_category["id"])
            # end
            # binding.pry
        # end
        end 
    end

    # def self.sub_sub_category(sub_id)
    #     response = HTTParty.get("https://api.wegmans.io/products/categories/#{sub_id}?api-version=2018-10-18&subscription-key=#{@@key}")#{|response, request, result| response }
    #     result = JSON.parse(response.body)
    #     # binding.pry

    #     items = result["categories"].each do |sub_sub_category|
    #         puts "#{sub_sub_category["id"]} - #{sub_sub_category["name"]}"

    #         sub_response = HTTParty.get("https://api.wegmans.io/products/categories/#{sub_sub_category["id"]}?api-version=2018-10-18&subscription-key=#{@@key}")#{|response, request, result| response }
    #         sub_result = JSON.parse(sub_response.body)
    #         sub_result["products"][1...5].each do |sub_product|
    #             # binding.pry
    #             Item.info(sub_product["sku"])
    #         end
    #         # Item.item_by_category(sub_sub_category["id"])
    #     end
    #     # return items
    #     # binding.pry
    # end

    def self.item_by_category(sub_id)
        # .collect do |sub_id|
        response = HTTParty.get("https://api.wegmans.io/products/categories/#{sub_id}?api-version=2018-10-18&subscription-key=#{@@key}")#{|response, request, result| response }
        result = JSON.parse(response.body)
        # binding.pry
        puts "#{result["products"].count} products"
        if result["products"].count == 0 
            puts "no"
        else
            return result["products"][0...5].each do |product|
                
                puts product
                puts product["sku"]
                
                Item.info(product["sku"])

                # Item.info(42564)
                # end
                # binding.pry
            end
        end
        # end
    end
    
    def self.info(sku)
        # skus = Item.item_by_category.sample(40)
        
        # binding.pry
        # return skus.each do |sku|
        response = HTTParty.get("https://api.wegmans.io/products/#{sku}?api-version=2018-10-18&subscription-key=#{@@key}") #{|response, request, result| response }
        result = JSON.parse(response.body)
        response_price = HTTParty.get("https://api.wegmans.io/products/#{sku}/prices?api-version=2018-10-18&subscription-key=#{@@key}")#{|response, request, result| response }
        result_price = JSON.parse(response_price.body)
        price = result_price["stores"][0]["price"]

        # binding.pry

        
        # binding.pry
        # if prod_image == nil || false || []
        #     placeholder_image = "https://assets.materialup.com/uploads/b03b23aa-aa69-4657-aa5e-fa5fef2c76e8/preview.png"
        # end
        name = result["name"]

        if result["tradeIdentifiers"][0]
            return result["tradeIdentifiers"][0]["images"][0]
            # placeholder_image = "https://assets.materialup.com/uploads/b03b23aa-aa69-4657-aa5e-fa5fef2c76e8/preview.png"
            # result["tradeIdentifiers"][0] = "https://assets.materialup.com/uploads/b03b23aa-aa69-4657-aa5e-fa5fef2c76e8/preview.png"
        else #result["tradeIdentifiers"][0] == nil || false # || []
            # return result["tradeIdentifiers"][0]["images"][0]
            return result["tradeIdentifiers"][0] = "https://assets.materialup.com/uploads/b03b23aa-aa69-4657-aa5e-fa5fef2c76e8/preview.png"
        end

        # if consumer_description == nil || false || []
        #     placeholder_desc = name
        # end
        if result["descriptions"]["consumer"] #== nil || false || []
            
            return result["descriptions"]["consumer"]
        else
            return result["descriptions"]["consumer"] = name
        end

        if result["descriptions"]["receipt"] #== nil || false || []
            # placeholder_receipt = name
            return result["descriptions"]["receipt"]
        else
            return result["descriptions"]["receipt"] = name
        end

        
        # prod_image = result["tradeIdentifiers"][0]["images"][0]
        # consumer_description = result["descriptions"]["consumer"]
        # receipt_info = result["descriptions"]["receipt"]
        
        # if sku == 30526
            # binding.pry
        # end

        # item = {
        #     item_id: sku, #sku number - product_url
        #     name: name, #product_url
        #     sales_price: price, #price_url
        #     description: consumer_description || placeholder_desc,
        #     receipt_info: receipt_info || placeholder_receipt,
        #     inventory_quantity: rand(50..100),
        #     image: prod_image || placeholder_image #result["tradeIdentifiers"][0]["images"][0]
        #     # nutrition: result["nutrition"][0]["description"]
        # }
        

        item = Item.create(
            item_id: sku, #sku number - product_url
            name: name, #product_url
            sales_price: price, #price_url
            description: result["descriptions"]["consumer"],
            receipt_info: result["descriptions"]["receipt"],
            inventory_quantity: rand(50..100),
            image: result["tradeIdentifiers"][0] || result["tradeIdentifiers"][0]["images"][0]
            # nutrition: result["nutrition"][0]["description"]
        )

        # binding.pry
        puts "#{item["name"]} CREATED"
        # puts "#{item["name"]}"
        # puts "#{item["item_id"]}"
        # puts "#{item["sales_price"]}"
        # puts "#{item["description"]}"
        # puts "#{item["receipt_info"]}"
        # puts "#{item["image"]}"
        # puts "\n"
        # puts "#{}"
        # puts "#{}"
        # puts "#{}"
        # puts "#{}"
        # binding.pry
        # end
            
    end

end

# Item.sub_category("561")
# Item.category