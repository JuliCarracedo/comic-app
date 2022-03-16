class ComicsController < ApplicationController
    def index 
    end
    def create 
        newComic = current_user.comics.build(comic_params)
        if newComic.save
            render json: {message: 'Success'}, status: 200
        else
            render json: {error: newComic.errors}, status: 422
        end
    end
    private

    def comic_params 
        params.require(:title, :description)
    end
end