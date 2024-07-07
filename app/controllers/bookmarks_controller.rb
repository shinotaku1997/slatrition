class BookmarksController < ApplicationController
    def create
        recipe = Recipe.find(params[:recipe_id])
        current_user.bookmark(recipe)
         redirect_to recipe_path(recipe), notice: "ブックマークしました"
    end
    
    def destroy
        recipe = current_user.bookmarks.find_by(params[:recipe_id]).recipe
        current_user.unbookmark(recipe)
        redirect_to recipe_path(recipe), notice: "ブックマークを解除しました"
    end
end
