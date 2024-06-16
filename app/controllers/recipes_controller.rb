require 'mechanize'

class RecipesController < ApplicationController
  before_action :require_login

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
    

  end

  private
  def recipe_params
    params.require(:recipe).permit(:individual_id)
  end

  def chat_params
    params.permit(:combined)
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
    chat_api = OpenAi::ChatApi.new("合計カロリー数,PFCだけ教えて。pタグで挟んで。")
    @combined = chat_api.chat(combined_text)
  end
end
