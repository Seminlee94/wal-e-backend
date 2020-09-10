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

    # def self.category
    #     # response = RestClient.get("https://api.wegmans.io/products/categories?api-version=2018-10-18", headers={'Subscription-Key': key}){|response, request, result| response }
    #     response = HTTParty.get("https://api.wegmans.io/products/categories?api-version=2018-10-18&subscription-key=#{@@key}") #{|response, request, result| response }
    #     result = JSON.parse(response.body)
    #     return result["categories"].each do |category|
    #         # category["name"]
    #         puts "#{category["id"]} - #{category["name"]}"
    #         Item.sub_category(category["id"])
    #     end
    #     # if we want category class - .each  key=["name"]
    # end
    
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
        # puts "#{result["products"].count} products"
        if result["products"].count == 0 
            puts "no"
        else
            return result["products"][0..9].each do |product|
                
                puts product
                puts product["sku"]
                
                Item.info(product["sku"])
                
                # Item.info(42564)
            end
        end
    end
    
    def self.info(sku)
        # binding.pry
        # skus = Item.item_by_category.sample(40)
        
        # return skus.each do |sku|
        response = HTTParty.get("https://api.wegmans.io/products/#{sku}?api-version=2018-10-18&subscription-key=#{@@key}")
        result = JSON.parse(response.body)
        response_price = HTTParty.get("https://api.wegmans.io/products/#{sku}/prices?api-version=2018-10-18&subscription-key=#{@@key}")
        result_price = JSON.parse(response_price.body)
        price = result_price["stores"][0]["price"]
      
        name = result["name"]
        if result["tradeIdentifiers"] == [] || result["tradeIdentifiers"][0]["images"] == []
            result["tradeIdentifiers"] = "https://assets.materialup.com/uploads/b03b23aa-aa69-4657-aa5e-fa5fef2c76e8/preview.png"
        else result["tradeIdentifiers"][0]["images"][0]
            result["tradeIdentifiers"] = result["tradeIdentifiers"][0]["images"][0]
        end

        if result["descriptions"]["consumer"] 
            result["descriptions"]["consumer"]
        else
            result["descriptions"]["consumer"] = name
        end
        
        if result["descriptions"]["receipt"] 
            result["descriptions"]["receipt"]
        else
            result["descriptions"]["receipt"] = name
        end
            
        item = Item.create!(
            item_id: sku, #sku number - product_url
            # category: "Category not found",
            # sub_category: "sub-category not found",
            name: name, #product_url
            sales_price: price, #price_url
            description: result["descriptions"]["consumer"],
            receipt_info: result["descriptions"]["receipt"],
            inventory_quantity: rand(50..100),
            image: result["tradeIdentifiers"],
            nutrition: result["nutrients"] 
        )
    end

    def self.search(query)
        search_query = query.split(" ").join("%20")
        response = HTTParty.get("https://api.wegmans.io/products/search?query=#{search_query}&api-version=2018-10-18&subscription-key=#{@@key}")
        # binding.pry
        response["results"][0...6].map do |item|
            sku = item["sku"]
            Item.info(sku)
        end
    end
end
