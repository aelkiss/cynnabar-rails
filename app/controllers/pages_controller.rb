class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  def show
  end

  def edit
  end

  def create
  end

  def new
    @page = Page.new
  end

  def index
    @pages = Page.all
  end

  def create
    @page = Page.new(page_params)
    if params[:commit] == 'Save' and @page.save
      redirect_to "/#{@page.slug}", notice: 'Page was successfully created.'
    else
      show_preview
      render :new
    end
  end

  def update
    if params[:commit] == 'Save' and @page.update(page_params) 
      redirect_to "/#{@page.slug}", notice: 'Page was successfully updated.'
    else
      show_preview
      render :edit
    end
  end

  private
    def show_preview
      # WARNING XSS VULNERABILITY
      if params[:page] and params[:page][:body]
        @body = params[:page][:body]
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:slug])

      if @page == nil
        render :not_found, :status => :not_found
        # raise ActionController::RoutingError.new('Not Found')
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:slug, :title, :body)
    end
end
