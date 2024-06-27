require 'mechanize'

class RecipesController < ApplicationController
  before_action :require_login
  before_action :recipe_params, only: [:create]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if Recipe.exists?(individual_id: @recipe.individual_id)
      @recipe = Recipe.find_by(individual_id: @recipe.individual_id)
      redirect_to recipe_path(id: @recipe.id)
    else 
      @individual_id = params[:individual_id]
      agent = Mechanize.new
      page = agent.get(@individual_id)
      @ingredients = page.search(".name").map(&:text)
      @amounts = page.search(".amount").map(&:text)
      @combined = @ingredients.zip(@amounts).map{ |pair| pair.join(": ") }
      
    end
  end

  def chat
    redirect_to recipe_path(id: params[:id]), action: :update
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update!(
      calories: @combined[0],
      proteins: @combined[1],
      carbhydrates: @combined[2],
      fats: @combined[3],
      salts: @combined[4],
      fibers: @combined[5]
    )
    redirect_to recipe_path(id: @recipe.id)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def details
    @recipe = Recipe.find(individual_id: params[:individual_id])
  end

  private
  def recipe_params
    params.require(:recipe).permit(:individual_id)
  end
end
