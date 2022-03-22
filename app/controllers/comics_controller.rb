class ComicsController < ApplicationController
    before_action :authenticate_user!
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

    def show 
       comic = Comic.find(params[:id])
       render json: { comic: comic }, status: 200 if comic
       render json: { error: {comic:["not found"]} }, status: 422 unless comic
    end
    private

    def comic_params 
        params.require(:comic).permit(:title, :description)
    end
end