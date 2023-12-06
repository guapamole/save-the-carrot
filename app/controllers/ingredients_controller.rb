class IngredientsController < ApplicationController
  before_action :find_ingredient, only: [:show, :edit, :update]

  def index
    @ingredients = Ingredient.all
    @recipe = Recipe.new
    if params[:query].present?
      @ingredients = @ingredients.where("name ILIKE ?", "%#{params[:query]}%")
    end
    # date_ajout_calcul()

  end

  def show
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = current_user.ingredients.build(ingredient_params)

    if @ingredient.save
      redirect_to_ingredient(@ingredient)
    else
      render :new
    end
  end

  def recipe_done
    @ingredient.recipe_ingredients.destroy_all
    redirect_to ingredient_path(@ingredient)
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

  def analyze_image
    img = params.dig(:photo).tempfile
    url = Cloudinary::Uploader.upload(img)["secure_url"]
    ImageDetectionJob.perform_later(current_user, url)
    redirect_to ingredients_results_path
  end

  def results
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to ingredients_path
  end

  # def date_ajout_calcul(ingredient)
  #   ingredient = Ingredient.find(params[:id])
  #   current_time = Time.now
  #   created_at = @ingredient.created_at
  #   difference_in_seconds = current_time - created_at
  #   difference_in_days = difference_in_seconds / 1.day
  #   @rounded_difference_in_days = difference_in_days.round
  # end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity, :purchase_date, :photo)
  end

  def find_ingredient
    @ingredient = Ingredient.find_by(id: params[:id])
  end

  def redirect_to_ingredient(ingredient)
    redirect_to ingredients_path(ingredient)
  end
end
