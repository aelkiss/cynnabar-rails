# frozen_string_literal: true
# Controller for Awardings - instances of awards given to recipients
class AwardingsController < ApplicationController
  load_and_authorize_resource

  # GET /awardings
  def index
    begin
      @start_date = params[:start_date] ? Date.parse(params[:start_date]) : nil
      @end_date = params[:end_date] ? Date.parse(params[:end_date]) : nil
    rescue ArgumentError
      flash[:error] = 'Invalid date format - use date picker or specify YYYY-MM-DD'
    end

    filter_by_date
  end

  # GET /awardings/1
  def show
  end

  # GET /awardings/new
  def new
    @awarding = Awarding.new(params.permit(:award_id, :recipient_id))
  end

  # GET /awardings/1/edit
  def edit
  end

  # POST /awardings
  def create
    @awarding = Awarding.new(awarding_params)

    if @awarding.save
      redirect_to @awarding, notice: 'Awarding was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /awardings/1
  def update
    if @awarding.update(awarding_params)
      redirect_to @awarding, notice: 'Awarding was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /awardings/1
  def destroy
    @awarding.destroy
    redirect_to awardings_url, notice: 'Awarding was successfully destroyed.'
  end

  private

  def nil_award_name
    if params[:other_award] && params[:other_award] == '1' &&
       params[:awarding][:award_name] && params[:awarding][:award_name].empty?
      params[:awarding][:award_name] = nil
    else
      params[:awarding][:award_name] = nil
      params[:awarding][:group_id] = nil
    end
  end

  def nil_unknown_date
    if params[:awarding][:received] && params[:awarding][:received].match(/unknown/i)
      params[:awarding][:received] = nil
    end
  end

  def awarding_params
    nil_award_name
    nil_unknown_date

    params.require(:awarding).permit(:award_id, :recipient_id, :received, :award_name, :group_id, :award_text)
  end

  def filter_by_date
    if @start_date && @end_date
      @awardings = Awarding.where('received >= ? and received <= ?', @start_date, @end_date).order(:received)
    else
      if @start_date || @end_date
        flash[:error] = 'To filter by date, both start date and end date must be provided'
      end
      @awardings = Awarding.order(:received)
    end
  end
end
