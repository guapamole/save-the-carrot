class Ingredient < ApplicationRecord
  belongs_to :user
  attribute :purchase_date, :date
  has_many_attached :photo
end
