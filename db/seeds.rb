# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "json"

puts 'Cleaning database...'
Ingredient.destroy_all
Cocktail.destroy_all


url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
ingredient_serialized = open(url).read
ingredient = JSON.parse(ingredient_serialized)

ingredient['drinks'].each do |i|
  Ingredient.create!( name: i['strIngredient1'])
end

url2 = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic"
cocktail_serialized = open(url2).read
cocktail = JSON.parse(cocktail_serialized)

cocktail['drinks'].each do |i|
  url = i['strDrinkThumb']
  coctail = Cocktail.new(name: i['strDrink'])
  coctail.remote_photo_url = url
  coctail.save
  # Cocktail.create!( name: i['strDrink'], photo: i['strDrinkThumb'])
  
end

puts "Finished"