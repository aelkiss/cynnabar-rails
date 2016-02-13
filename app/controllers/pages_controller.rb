class PagesController < ApplicationController
  load_and_authorize_resource id_param: 'slug'

  def show
  end

  def edit
  end

  def new
    @page = Page.new
  end

  def index
    @pages = Page.all
  end

  def create
    # required for what ckeditor sends
    response.headers["X-XSS-Protection"] = 0
    if params[:commit] == 'Save' 
      check_set_owner
      if @page.save
        redirect_to "/#{@page.slug}", notice: 'Page was successfully created.'
      else
        render :new
      end
    else
      show_preview
      render :new
    end
  end

  def update
    # required for what ckeditor sends
    response.headers["X-XSS-Protection"] = 0
    if params[:commit] == 'Save'
      check_set_owner
      if @page.update(page_params) 
        redirect_to "/#{@page.slug}", notice: 'Page was successfully updated.'
      else
        render :edit
      end
    else
      show_preview
      render :edit
    end
  end

  private

    def check_set_owner
      params.require(:page)
      if params[:page][:user_email] 
        authorize! :set_owner, @page
        @page.user = User.find_by_email!(params[:page][:user_email])
      elsif @page.user == nil
        authorize! :set_owner, @page
        @page.user = current_user
      end
    end

    def show_preview
      params.require(:page)
      if params[:page][:body]
        @body = params[:page][:body]
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      [:calendar_details, :calendar_title, :calendar].each do |param|
        params[:page][param] = nil if params[:page][param] and params[:page][param].empty?
      end
      params.require(:page).permit(:slug, :title, :body, :calendar, :calendar_details, :calendar_title)
    end
end
