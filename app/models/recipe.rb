require "open-uri"

class Recipe < ApplicationRecord
  belongs_to :cookbook
  has_many :recipe_ingredients
  has_one_attached :photo
end
