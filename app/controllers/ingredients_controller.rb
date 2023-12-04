class IngredientsController < ApplicationController
  before_action :find_ingredient, only: [:show, :edit, :update]

  def index
    @ingredients = Ingredient.all
    @recipe = Recipe.new
    if params[:query].present?
      @ingredients = @ingredients.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def show
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = current_user.ingredients.build(ingredient_params)

    if save_and_analyze_image
      redirect_to_ingredient(@ingredient)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to_ingredient(@ingredient)
    else
      render :edit
    end
  end

  def add_an_image
    ingredients_param = params.dig(:choices, :ingredients)

    if ingredients_param.present?
      ingredient_names = ingredients_param.map { |id| Ingredient.find_by(id: id)&.name }
    end
  end

  def analyse_image
    img = params.dig(:photo).tempfile
    response = Cloudinary::Uploader.upload(img)
    url = response["secure_url"]

    ImageDetection.new(current_user, url).generate
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity, :purchase_date)
  end

  def find_ingredient
    @ingredient = Ingredient.find_by(id: params[:id])
  end

  def redirect_to_ingredient(ingredient)
    redirect_to ingredients_path(ingredient)

  end
end


# {
#   indredients: {
#     eggs: 2,
#     tomatoes: 3
#   }}
