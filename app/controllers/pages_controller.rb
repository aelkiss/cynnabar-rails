# frozen_string_literal: true
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
    response.headers['X-XSS-Protection'] = 0
    save_page_or_preview(:new, &:save)
  end

  def update
    # required for what ckeditor sends
    response.headers['X-XSS-Protection'] = 0
    save_page_or_preview(:edit) { |page| page.update(page_params) }
  end

  def destroy
    @page.destroy
    redirect_to pages_path, notice: 'Page was successfully deleted.'
  end

  def logo
    @page&.logo || super
  end

  def menu
    @page&.menu || super
  end

  private

  def check_set_owner
    params.require(:page)
    if params[:page][:user_id]
      authorize! :set_owner, @page
      @page.user = User.find(params[:page][:user_id])
    elsif @page.user.nil?
      authorize! :set_owner, @page
      @page.user = current_user
    end
  end

  def show_preview
    params.require(:page)
    @body = params[:page][:body] if params[:page][:body]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    [:calendar_details, :calendar_title, :calendar, :user_id, :logo, :menu].each do |param|
      params[:page][param] = nil if params[:page][param] && params[:page][param].empty?
    end
    params.require(:page).permit(:slug, :title, :body, :calendar, :calendar_details, :calendar_title, :user_id, :logo, :menu)
  end

  def save_page_or_preview(template, &block)
    if params[:commit] == 'Save'
      check_set_owner
      try_save_page(template, &block)
    else
      show_preview
      render template
    end
  end

  def try_save_page(template)
    if yield(@page)
      redirect_to "/#{@page.slug}", notice: 'Page was successfully created.'
    else
      render template
    end
  end
end
