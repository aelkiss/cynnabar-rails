# frozen_string_literal: true
class OfficesController < ApplicationController
  load_and_authorize_resource

  # GET /offices
  # GET /offices.json
  def index
  end

  # GET /offices/1
  # GET /offices/1.json
  def show
    redirect_to @office.page
  end

  # GET /offices/new
  def new
  end

  # GET /offices/1/edit
  def edit
  end

  # POST /offices
  # POST /offices.json
  def create
    if @office.save
      redirect_to @office.page, notice: 'Office was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /offices/1
  # PATCH/PUT /offices/1.json
  def update
    if @office.update(office_params)
      redirect_to @office.page, notice: 'Office was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /offices/1
  # DELETE /offices/1.json
  def destroy
    @office.destroy
    redirect_to offices_url, notice: 'Office was successfully destroyed.'
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def office_params
    params.require(:office).permit(:name, :email, :image, :page_id, :officer_id)
  end
end
