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
      redirect_to result_recipe_path(id: @recipe.individual_id)
    elsif @recipe.save
      redirect_to result_recipe_path(id: @recipe.individual_id)
    else 
      render :new
    end
  end

  def result
    @individual_id = params[:individual_id]
    agent = Mechanize.new
    page = agent.get(@individual_id)
    @ingredients = page.search(".name").map(&:text)
    @amounts = page.search(".amount").map(&:text)
    @combined = @ingredients.zip(@amounts).map{ |pair| pair.join(": ") }
    redirect_to recipes_chat_path(id: @recipe.id, combined: @combined)
  end

  def chat
    pp params[:combined]
    combined_text = params[:combined].join(", ")
    chat_api = OpenAi::ChatApi.new("totalcalories,proteins,carbhydrates,fats,salts,fibersの数値だけ答えてください。各項目の前に[,]つけて。例: 100,200,300,400,500,600")
    @combined = chat_api.chat(combined_text)
    @combined = @combined.split(",")
    redirect_to recipe_path(id: params[:individual_id])
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
    redirect_to recipes_show_path(id: @recipe.id)
  end
  
  def details
    @recipe = Recipe.find(individual_id: params[:individual_id])
  end

  private
  def recipe_params
    params.require(:recipe).permit(:individual_id)
  end
end
