class Ingredient < ApplicationRecord
  belongs_to :user
  attribute :purchase_date, :date
end
