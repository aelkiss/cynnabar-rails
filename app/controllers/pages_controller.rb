class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  def show
  end

  def edit
    # WARNING XSS VULNERABILITY
    if params[:page] and params[:page][:body]
      @body = params[:page][:body]
    end
  end

  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Award was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_page_not_found
    if @page == nil
      render :not_found, :status => :not_found
      # raise ActionController::RoutingError.new('Not Found')
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = nil

      if params[:slug]  
        @page = Page.find_by_slug(params[:slug])
      elsif params[:id] 
        @page = Page.find(params[:id])
      end

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
