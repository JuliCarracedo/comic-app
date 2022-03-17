class ComicsController < ApplicationController
    def index 
    end
    def create 
        new_comic = current_user.comics.build(comic_params)
        if new_comic.save
            render json: {message: 'Successfully created'}, status: 200
        else
            render json: {error: new_comic.errors}, status: 422
        end
    end
    def update 
        comic = Comic.find(params[:id])
        if comic.update(comic_params)
            render json: {message: 'Successfully updated'}, status: 200 
        else
            render json: {error: comic.errors}, status: 422
        end
    end
    private

    def comic_params 
        params.require(:title, :description)
    end
end