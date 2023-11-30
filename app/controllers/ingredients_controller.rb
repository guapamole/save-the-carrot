class IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.all
    @recipe = Recipe.new
  end

  def show
    @ingredient = Ingredient.find_by(id: params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = current_user.ingredients.build(ingredient_params)
    puts "Params: #{params.inspect}"
    if @ingredient.save
      redirect_to ingredients_path, notice: "Ingrédient ajouté avec succès."
    else
      render :new, alert: "Problème lors de l'ajout de l'ingrédient."
    end
  end

  def edit
    @ingredient = Ingredient.find_by(id: params[:id])
  end

  def update
    ingredient = Ingredient.find_by(id: params[:id])
    ingredient.update(ingredient_params)
    redirect_to ingredient_path(ingredient)
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity, :purchase_date)
  end

  def analyze_image
    response_json = [
  {
    "model_id": 8201,
    "model_title": "Chooch-ImageChat-3",
    "predictions": [
      {
        "class_title": "cucumbers, tomatoes, jars, yogurt, ketchup, cucumbers, ice cream,",
        "score": 0.999,
        "prompt": "What's in the fridge ?",
        "model_id": 8201,
        "model_title": "Chooch-ImageChat-3",
        "prediction_keywords": [
          "ice cream",
          "cucumbers",
          "ketchup",
          "yogurt",
          "jars",
          "tomatoes",
          "salsa",
          "pickles",
          "jar",
          "is"
        ],
        "coordinates": {
          "xmin": 0,
          "ymin": 0,
          "xmax": 800,
          "ymax": 1000
        },
        "model_uuid": "ad420c2a-d565-48eb-b963-a8297a0e4000",
        "model_name": "food detection"
      },
      {
        "class_title": "There is a jar of pickles, a jar of ketchup, a jar of salsa, a ",
        "score": 0.999,
        "prompt": "Describe me every aliment in the fridge",
        "model_id": 8201,
        "model_title": "Chooch-ImageChat-3",
        "prediction_keywords": [
          "ice cream",
          "cucumbers",
          "ketchup",
          "yogurt",
          "jars",
          "tomatoes",
          "salsa",
          "pickles",
          "jar",
          "is"
        ],
        "coordinates": {
          "xmin": 0,
          "ymin": 0,
          "xmax": 800,
          "ymax": 1000
        },
        "model_uuid": "ad420c2a-d565-48eb-b963-a8297a0e4000",
        "model_name": "food detection"
      }
    ],
    "model_type": "Chooch-ImageChat-3",
    "prompt": [
      "What's in the fridge ?",
      "Describe me every aliment in the fridge "
    ],
    "prediction_type": "Chooch-ImageChat-3",
    "image_width": 1000,
    "image_height": 800,
    "image_id": "65c947cf-8924-4b18-ab83-64a666cd948d.jpg",
    "image_meta": "https://choochdashboard.s3.amazonaws.com/object_detection_test_file/15985-img-5912_PgCpjYK.jpg",
    "image_url": "https://choochdashboard.s3.amazonaws.com/object_detection_test_file/15985-img-5912_PgCpjYK.jpg"
  }
]

  end
end
