class AwardingsController < ApplicationController
  load_and_authorize_resource

  # GET /awardings
  # GET /awardings.json
  def index

    begin
      @start_date = params[:start_date] ? Date.parse(params[:start_date]) : nil
      @end_date = params[:end_date] ?  Date.parse(params[:end_date]) : nil
    rescue ArgumentError
      flash[:error] = "Invalid date format - use date picker or specify YYYY-MM-DD"
    end

    if @start_date and @end_date
      @awardings = Awarding.where("received >= ? and received <= ?",@start_date,@end_date).order(:received)
    else
      if @start_date or @end_date
        flash[:error] = "To filter by date, both start date and end date must be provided"
      end
      @awardings = Awarding.order(:received)
    end
  end

  # GET /awardings/1
  # GET /awardings/1.json
  def show
  end

  # GET /awardings/new
  def new
    @awarding = Awarding.new(params.permit(:award_id,:recipient_id))
  end

  # GET /awardings/1/edit
  def edit
  end

  # POST /awardings
  # POST /awardings.json
  def create
    @awarding = Awarding.new(awarding_params)

    respond_to do |format|
      if @awarding.save
        format.html { redirect_to @awarding, notice: 'Awarding was successfully created.' }
        format.json { render :show, status: :created, location: @awarding }
      else
        format.html { render :new }
        format.json { render json: @awarding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /awardings/1
  # PATCH/PUT /awardings/1.json
  def update
    respond_to do |format|
      if @awarding.update(awarding_params)
        format.html { redirect_to @awarding, notice: 'Awarding was successfully updated.' }
        format.json { render :show, status: :ok, location: @awarding }
      else
        format.html { render :edit }
        format.json { render json: @awarding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /awardings/1
  # DELETE /awardings/1.json
  def destroy
    @awarding.destroy
    respond_to do |format|
      format.html { redirect_to awardings_url, notice: 'Awarding was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def awarding_params
    if(params[:other_award] and params[:other_award] == '1')
      params[:awarding][:award_name] = nil if params[:awarding][:award_name] and params[:awarding][:award_name].empty?
    else 
      params[:awarding][:award_name] = nil
      params[:awarding][:group_id] = nil
    end

    if params[:awarding][:received] and params[:awarding][:received].match(/unknown/i)
      params[:awarding][:received] = nil
    end
    
    params.require(:awarding).permit(:award_id, :recipient_id, :received, :award_name, :group_id)

  end
end
