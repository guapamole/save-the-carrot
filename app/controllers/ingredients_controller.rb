class IngredientsController < ApplicationController
  before_action :find_ingredient, only: [:show, :edit, :update]

  def index
    @ingredients = Ingredient.all
    @recipe = Recipe.new
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

    File.open(img.path) do |file|
      @ingredient = Ingredient.new
      @ingredient.photo.attach(io: file, filename: 'analyzed_image.jpg', content_type: 'image/jpeg')
    end

    url = Cloudinary::Uploader.upload(img)["secure_url"]

    ImageDetection.new(current_user, url).generate
  end


  def create_from_photo
    details = analyze_image
    raise

    # @ingredient.new
    # ingredient.name = details[:name]

    if @ingredient.save
      redirect_to_ingredient(@ingredient)
    else
      render :new
    end
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
