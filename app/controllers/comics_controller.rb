class ComicsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :authorize_request

    def index
        if params[:user_id]
            comics = User.find(params[:user_id]).comics
            display_comics = comics.map do |comic| 
                    return {id: comic.id,
                            title: comic.title,
                            description: comic.description,
                            thumbnail_url: comic.thumbnail_url }
                end
            render json: {comics: display_comics}, status: 200 
        end
    end

    def create 
        new_comic = @current_user.comics.build(comic_params)
        if new_comic.save
            render json: {message: 'Successfully created'}, status: 200
        else
            render json: {error: new_comic.errors}, status: 422
        end
    end

    def update 
        comic = Comic.find(params[:id])
        if comic_params[:title] || comic_params[:description]
            if comic.update(comic_params)
                render json: {message: 'Successfully updated'}, status: 200 
            else
                render json: {error: comic.errors}, status: 422
            end
        end
    end

    def show

      if params[:id]
        redirect_to action: :index unless params[:id]
        comic = Comic.find(params[:id])
        render json: { comic: comic }, status: 200 if comic
        render json: { error: {comic:["not found"]} }, status: 422 unless comic
      else
        comics= Comic.all
        render json: { comics: comics }, status: 200
      end

    end

    def destroy 
        comic = Comic.find(params[:id])
        if comic && current_user === comic.user
            comic.destroy
            render json: { message: "Successfully destroyed" }, status: 200 
        elsif current_user !== comic.user
            render json: { error: {comic:["can't be deleted by anyone but its author"]} }, status: 422 
        else
            render json: { error: {comic:["not found"]} }, status: 422 
        end
    end

    private

    def comic_params 
        params.require(:comic).permit(:title, :description, :thumbnail)
    end
end