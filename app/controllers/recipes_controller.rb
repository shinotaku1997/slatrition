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
      agent = Mechanize.new
      page = agent.get(@recipe.individual_id)
      @ingredients = page.search(".name").map(&:text)
      @amounts = page.search(".amount").map(&:text)
      @combined = @ingredients.zip(@amounts).map{ |pair| pair.join(": ") }

      combined_text = @combined.join(",")
      chat_api = OpenAi::ChatApi.new("totalcalories,proteins,carbhydrates,fats,salts,fibersの数値だけ答えてください。各項目の前に[,]つけて。例: 100,200,300,400,500,600")
      chat_responce = chat_api.chat(combined_text)
      @combined = chat_responce.split(",")
      @recipe = Recipe.new(
        individual_id: @recipe.individual_id,
        calories: @combined[0],
        proteins: @combined[1],
        carbhydarates: @combined[2],
        fats: @combined[3],
        salts: @combined[4],
        fibers: @combined[5])
        if @recipe.save
          flash[:success] = "Recipe created"
          redirect_to recipe_path(id: @recipe.id)
        else
          render :new
        end
    end
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
