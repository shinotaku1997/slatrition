require 'mechanize'

class RecipesController < ApplicationController
  skip_before_action :require_login

  def new
    @recipe = Recipe.new
  end

  def result
    @individual_id = params[:individual_id]
    agent = Mechanize.new
    page = agent.get(@individual_id)
    @ingredients = page.search(".name").map(&:text)
    @amounts = page.search(".amount").map(&:text)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipes_result_path(individual_id: @recipe.individual_id)
    else
      render :new
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:individual_id)
  end
end
