class PageController < ApplicationController
  def show
    @page = Page.find_by_slug(params[:slug])

    if @page == nil
      render :not_found, :status => :not_found
      # raise ActionController::RoutingError.new('Not Found')
    end
  end
end
