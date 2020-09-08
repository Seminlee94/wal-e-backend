# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require './app/models/wegman_api_data.rb'

# Item.destroy_all
User.destroy_all
Cart.destroy_all
# CartItem.destroy_all

puts "starting"

puts "users"

User.create(name: 'Alex',  username: 'alexb', password: 'password1')
User.create(name: 'Se Min', username: 'seminL', password: 'password2')

puts "items"


# Item.category
# Item.item_by_category("561-562") ## ""Bread, Packaged""
# Item.item_by_category("561-563") ## ""Stuffing, Pitas, Flatbreads, Wraps & Pizza Shells""
# Item.item_by_category("561-564") ## "Rolls"
# Item.item_by_category("561-565") ## "Breakfast"
# Item.item_by_category("561-566") ## "Desserts & Pastries"
# Item.item_by_category("561-907") ## "Bread, Fresh Baked"
# Item.item_by_category("561-1661") ## "Cakes"
# Item.item_by_category("561-1662") ## "Cookies"
# Item.item_by_category("917-920") ## "Cave-Ripened Cheese"
# Item.item_by_category("917-921") ## "Feta Cheese"
# Item.item_by_category("917-922") ## "Blue Cheese"
# Item.item_by_category("917-930") ## "Italian Cheese"
# Item.item_by_category("917-937") ## "Fresh Cheese & Butters"
# Item.item_by_category("917-6980") ## "Cheddar, Gouda, Swiss & more"
# Item.item_by_category("917-6981") ## "Goat & Sheep"
# Item.item_by_category("917-6982") ## "Mediterranean Antipasto"
# Item.item_by_category("917-6983") ## "Snacking & Entertaining"
Item.item_by_category("917-6984") ## "Accompaniments"
# Item.sub_category("917")
# Item.sub_category("6642")
# Item.sub_category("6940")
# Item.sub_category("6941")
# Item.sub_category("6942")
# Item.sub_category("7221")


# 10.times do
#     Item.create(item_id: Faker::IDNumber.valid, name: Faker::Commerce.product_name, sales_price: rand(2.00..6.00).round(2), description: Faker::Hipster.paragraphs(number: 1))
# end

puts "carts"


Cart.create(user_id: User.first.id)
Cart.create(user_id: User.second.id)


puts "item_carts"

# 5.times do
#     CartItem.create(item_id: Item.all.sample.id, cart_id: Cart.all.sample.id)
# end

puts "done"