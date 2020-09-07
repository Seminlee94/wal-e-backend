# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require './app/models/wegman_api_data.rb'

User.destroy_all
Item.destroy_all
Cart.destroy_all
# CartItem.destroy_all

puts "starting"

puts "users"

User.create(name: 'Alex',  username: 'alexb', password: 'password1')
User.create(name: 'Se Min', username: 'seminL', password: 'password2')

puts "items"


# Item.category
Item.sub_category("561")
Item.item_by_category
Item.info
# Item.create_item
# Item.populate

# 10.times do
#     Item.create(item_id: Faker::IDNumber.valid, name: Faker::Commerce.product_name, sales_price: rand(2.00..6.00).round(2), description: Faker::Hipster.paragraphs(number: 1))
# end

puts "carts"


Cart.create(user_id: User.first)
Cart.create(user_id: User.second)


puts "item_carts"

# 5.times do
#     CartItem.create(item_id: Item.all.sample.id, cart_id: Cart.all.sample.id)
# end

puts "done"