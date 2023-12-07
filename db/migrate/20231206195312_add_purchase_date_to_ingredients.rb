class AddPurchaseDateToIngredients < ActiveRecord::Migration[7.1]
  def change
    add_column :ingredients, :purchase_date, :datetime
  end
end
