class RecipesController < ApplicationController
  load_and_authorize_resource
  def index
    @current_user = current_user
    @recipes = current_user.recipes
  end

  def show
    @current_user = current_user
    @recipe = Recipe.find_by_id(params[:id])
    @ingredients = @recipe&.recipe_foods
  end

  def new
    @recipe = Recipe.new
    @current_user = current_user
  end

  def create
    @current_user = current_user
    @recipe = Recipe.new(recipe_params.merge(user_id: @current_user.id))

    if @recipe.save
      redirect_to recipes_path notice: 'Recipe created successfully 👏🏻'
    else
      flash[:alert] = 'Recipe not created'
      redirect_to recipes_path
    end
  end

  def public_recipes
    @current_user = current_user
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def destroy
    @recipe = Recipe.find_by_id(params[:id])
    redirect_to recipes_path if @recipe.destroy
  end

  def toggle_public
    @recipe = Recipe.find_by_id(params[:recipe_id])
    @recipe.public = !@recipe.public

    redirect_to recipe_path(@recipe.id), notice: 'Recipe updated successfully 👏🏻' if @recipe.save
  end

  def generate_list
    redirect_to shopping_list_path(params[:recipe_id])
  end

  def generate
    @quantity = []
    @foods = []
    @recipe_food = RecipeFood.where(recipe_id: params[:recipe_id])
    @recipe_food.each do |rf|
      found = false
      check_recipe_food = Food.find(rf.food_id)
      @quantity << [rf.quantity, check_recipe_food.price]
      @foods << check_recipe_food.name
    end
    @total = 0
    @quantity.each do |q|
      @total += q[0].to_i * q[1].to_i
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
