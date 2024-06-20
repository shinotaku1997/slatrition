require 'mechanize'

class RecipesController < ApplicationController
  before_action :require_login
  before_action :recipe_params, only: [:create]

  def new
    @recipe = Recipe.new
  end

  def create
    # ①URLを入力
    # ②URL保存時、重複しているかどうかを確認する
    # ③重複している場合は保存しない、DBから情報を呼び出す
    # ④重複していない場合は保存する
    # ⑤保存したURLを元に、材料と分量を取得する
    # ⑥取得した材料と分量を元に、OpenAIにリクエストを送る
    # ⑦OpenAIからのレスポンスを元に、レシピを作成する
    # ⑧保存したURLに紐づける形で、カロリーや含有量を保存する
    @recipe = Recipe.new(recipe_params)
    if Recipe.exists?(individual_id: @recipe.individual_id)
      @recipe = Recipe.find_by(individual_id: @recipe.individual_id)
      redirect_to recipes_result_path(individual_id: @recipe.individual_id)
    elsif @recipe.save
      redirect_to recipes_result_path(individual_id: @recipe.individual_id)
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
    redirect_to recipes_chat_path(combined: @combined)
  end

  def chat
    pp params[:combined]
    combined_text = params[:combined].join(", ")
    chat_api = OpenAi::ChatApi.new("totalcalories,proteins,carbhydrates,fats,salts,fibersの数値だけ答えてください。各項目の前に[,]つけて。例: 100,200,300,400,500,600")
    @combined = chat_api.chat(combined_text)
    @combined = @combined.split(",")
  end

  def update
    @recipe = Recipe.find(params[:individeal_id])
    if @recipe.update(@combined)
      redirect_to recipes_result_path(individual_id: @recipe.individual_id )
    else
      render :chat
    end
  end
  

  private
  def recipe_params
    params.require(:recipe).permit(:individual_id)
  end

  def chat_params
    params.permit(:combined)
  end
end
