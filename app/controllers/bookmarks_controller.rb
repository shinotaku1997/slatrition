class BookmarksController < ApplicationController
    def create
        @recipe = Recipe.find(params[:recipe_id])
    #Boardモデルからboard_idを探してくる。
        current_user.bookmark(@recipe)
    # ログイン中のユーザーと紐づけられたidを取ってくる。この時、user.rbに定義したaliasを使用し、idの情報を保存する。
    end
    
    def destroy
        @recipe = current_user.bookmarks.find(params[:recipe_id]).recipe
        current_user.unbookmark(@recipe)
        # redirect_backはユーザーが直前にリクエストを送ったページに戻す
        # fallback_location: デフォルトの設定
    end
end
