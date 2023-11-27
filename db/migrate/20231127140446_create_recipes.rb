class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.references :cookbook, null: false, foreign_key: true
      t.string :name
      t.integer :difficulty
      t.time :preptime
      t.time :cooking_time
      t.string :meal_type

      t.timestamps
    end
  end
end
