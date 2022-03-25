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

end