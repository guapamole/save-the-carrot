class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.date :exipration_date
      t.integer :quantity
      t.integer :kcal

      t.timestamps
    end
  end
end
