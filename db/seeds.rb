# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Recipe.destroy_all
Cookbook.destroy_all
User.destroy_all

user =
User.create(email: "savethecarotts@rabbit.com", password: "coucou")
User.create(email: "hello@lapin.com", password: "coucou")

Ingredient.create(name: "carotte", user: user, quantity: 2)
Ingredient.create(name: "steack haché", user: user, quantity: 5)
Ingredient.create(name: "haricot vert", user: user, quantity: 7)
Ingredient.create(name: "choux fleur", user: user, quantity: 3)
Ingredient.create(name: "oeufs", user: user, quantity: 9)
