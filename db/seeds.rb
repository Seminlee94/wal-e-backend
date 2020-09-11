# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require './app/models/wegman_api_data.rb'

# Item.destroy_all
# User.destroy_all
# Cart.destroy_all
CartItem.destroy_all

puts "starting"

puts "users"

# User.create(name: 'Alex',  username: 'alexb', password: 'password1')
# User.create(name: 'Se Min', username: 'seminL', password: 'password2')

puts "items"


# Item.category
# Item.item_by_category("561-562") ## ""Bread, Packaged"
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
# Item.item_by_category("6940-4149") ## "Accompaniments"
# Item.item_by_category("6940-716")  # Beef
# Item.item_by_category("6940-717")  # Pork
# Item.item_by_category("6940-722")  # Ground Meat
# Item.item_by_category("6940-723")  # Turkey
# Item.item_by_category("6940-725")  # Sausage 
# Item.item_by_category("6940-6960") # Lamb, Veal, & Other Meat
# Item.item_by_category("6940-7222") # Ham
# Item.item_by_category("6940-7224") # Chicken
# Item.item_by_category("6940-7241") # Bacon
# Item.item_by_category("6940-7242") # Halal Meat
# Item.item_by_category("7221-851")  # Crab and Lobster
# Item.item_by_category("7221-853")  # Frozen Shrimp & Seafood
# Item.item_by_category("7221-855")  # Fresh Seafood
# Item.item_by_category("7221-1034") # Smoked, Spreads & More
# Item.item_by_category("7221-1263") # Ready to Cook Seafood




# 10.times do
#     Item.create(item_id: Faker::IDNumber.valid, name: Faker::Commerce.product_name, sales_price: rand(2.00..6.00).round(2), description: Faker::Hipster.paragraphs(number: 1))
# end

puts "carts"


# Cart.create(user_id: User.first.id)
# Cart.create(user_id: User.second.id)


puts "item_carts"

5.times do
    CartItem.create(item_id: Item.all.sample.id, cart_id: Cart.all.sample.id, quantity: 1)
end

puts "done"