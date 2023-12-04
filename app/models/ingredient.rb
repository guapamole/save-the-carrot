class Ingredient < ApplicationRecord
  belongs_to :user
  attribute :purchase_date, :date
  has_one_attached :photo
end
