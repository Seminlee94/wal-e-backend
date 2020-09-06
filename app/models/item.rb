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
        # binding.pry
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
        # key = ENV["WEGMAN_API_KEY"]
        Item.sub_category.collect do |sub_id|
            response = HTTParty.get("https://api.wegmans.io/products/categories/#{sub_id}?api-version=2018-10-18&subscription-key=#{@@key}")#{|response, request, result| response }
            result = JSON.parse(response.body)
            # binding.pry
            return result["products"].collect do |product|
                product["sku"]
            end
        end
    end

    def self.info
        # key = ENV["WEGMAN_API_KEY"]
        skus = Item.item_by_category.sample(40)

        return skus.collect do |sku|
            response = HTTParty.get("https://api.wegmans.io/products/#{sku}?api-version=2018-10-18&subscription-key=#{@@key}") #{|response, request, result| response }
            result = JSON.parse(response.body)
            # binding.pry
        end
    end

    def self.create_item
        items = Item.info
        key = ENV["WEGMAN_API_KEY"]
        # binding.pry
        items.each do |item|
            # response = HTTParty.get("https://api.wegmans.io/products/#{item["sku"]}/prices?api-version=2018-10-18&subscription-key=#{@@key}")#{|response, request, result| response }
            response = RestClient.get("https://api.wegmans.io/products/756507/prices?api-version=2018-10-18", headers={'Subscription-Key': 'c455d00cb0f64e238a5282d75921f27e'}){|response, request, result| response }
            binding.pry
            result = JSON.parse(response.body)
            price = result["stores"][0]["price"]
            Item.populate(item, price)
        end
    end

    def self.populate(response, price)
        binding.pry
        Item.find_or_create_by(
            item_id: response["sku"], #sku number - product_url
            name: respone["name"], #product_url
            sales_price: price, #price_url
            description: response["descriptions"]["consumer"],
            receipt_info: respone["descriptions"]["receipt"],
            inventory_quantity: rand(50..100),
            image: response["tradeIdentifiers"][0]["images"][0],
            nutrition: response["nutrition"][0]["description"]
        )
    end
end