class ChaptersController < ApplicationController
    before_action :authenticate_user!
    def show

        if params[:id]
           comic = Comic.find(params[:id])
           pages = Comic.pages
           pages = pages.sort_by{|page| page.number}
           render json: {comic: comic, pages: pages}, status: 200
       end

    end

    def create

        page_urls = params[:page_urls] #An array of urls
        comic = current_user.comics.build(comic_params)
        if comic.save
            page_urls.each do |url, index|
                page = comic.pages.build(page_url: url, number: index + 1)
                page.save
            end

            render json: {message: 'Successfully created'}, status: 200
        else
            render json: {error: comic.errors}, status: 422
        end
    end

    def destroy
        if params[:id]
            Comic.find(params[:id]).destroy
            render json: {message: 'Successfully deleted'}, status: 200
        end
    end

    private

    def comic_params
        params.require(:comic).permit(:title,:description,:thumbnail_url)
    end

end