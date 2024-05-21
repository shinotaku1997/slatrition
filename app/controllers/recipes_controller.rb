require 'mechanize'

class RecipesController < ApplicationController
  def new
    agent = Mechanize.new
    page = agent.get('https://cookpad.com/recipe/2589170')
    @recipe = page.search(".ingredient_row")
  end
end
