require 'pry'
require 'json'
# require "uri"
# require "net/http"
require "dotenv"
require "rest-client"
# require_relative "./item.rb"
require "httparty"
Dotenv.load

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
        return result["categories"].collect do |category|
            # category["name"]
            category["id"]
        end
        # if we want category class - .each  key=["name"]
    end
    
    def self.sub_category
        Item.category.collect do |id| 
            response = HTTParty.get("https://api.wegmans.io/products/categories/#{id}?api-version=2018-10-18&subscription-key=#{@@key}") #{|response, request, result| response }
            result = JSON.parse(response.body)
            return result["categories"].collect do |sub_category|
                sub_category["id"]
            end
        end 
    end

    def self.item_by_category
        Item.sub_category.collect do |sub_id|
            response = HTTParty.get("https://api.wegmans.io/products/categories/#{sub_id}?api-version=2018-10-18&subscription-key=#{@@key}")#{|response, request, result| response }
            result = JSON.parse(response.body)
            return result["products"].collect do |product|
                product["sku"]
            end
        end
    end
    
    def self.info
        skus = Item.item_by_category.sample(40)

        return skus.each do |sku|
            response = HTTParty.get("https://api.wegmans.io/products/#{sku}?api-version=2018-10-18&subscription-key=#{@@key}") #{|response, request, result| response }
            result = JSON.parse(response.body)
            response_price = HTTParty.get("https://api.wegmans.io/products/#{sku}/prices?api-version=2018-10-18&subscription-key=#{@@key}")#{|response, request, result| response }
            result_price = JSON.parse(response_price.body)
            price = result_price["stores"][0]["price"]
            # binding.pry
            
            Item.find_or_create_by(
                item_id: result["sku"], #sku number - product_url
                name: result["name"], #product_url
                sales_price: price, #price_url
                description: result["descriptions"]["consumer"],
                receipt_info: result["descriptions"]["receipt"],
                inventory_quantity: rand(50..100),
                image: result["tradeIdentifiers"][0]["images"][0]
                # nutrition: result["nutrition"][0]["description"]
            )

            binding.pry
        end
            
    end

    # def self.create_item
        # items = Item.item_by_category.sample(40)
        # items.each do |item|
            # response = RestClient.get("https://api.wegmans.io/products/756507/prices?api-version=2018-10-18", headers={'Subscription-Key': 'c455d00cb0f64e238a5282d75921f27e'}){|response, request, result| response }
            # price = result["stores"][0]["price"]
        # end
    # end

    # def self.populate(response, price)
    #     binding.pry
    #     Item.find_or_create_by(
    #         item_id: response["sku"], #sku number - product_url
    #         name: respone["name"], #product_url
    #         sales_price: price, #price_url
    #         description: response["descriptions"]["consumer"],
    #         receipt_info: respone["descriptions"]["receipt"],
    #         inventory_quantity: rand(50..100),
    #         image: response["tradeIdentifiers"][0]["images"][0],
    #         nutrition: response["nutrition"][0]["description"]
    #     )
    # end
    #
end