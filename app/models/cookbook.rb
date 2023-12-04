class Cookbook < ApplicationRecord
  belongs_to :user
  has_many :recipes
  has_one_attached :photo
end
