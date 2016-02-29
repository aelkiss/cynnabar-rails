class RecipientsController < ApplicationController
  load_and_authorize_resource

  # override autocomplete from rails-autocomplete to search composite 
  def autocomplete_recipient_name
    term = params[:term]

    if term && !term.blank?
      items = search_recipients(term)
    else
      items = {}
    end

    render :json => json_for_autocomplete(items, :to_s)

  end

  # GET /recipients
  # GET /recipients.json
  def index
    order = "coalesce(sca_name,mundane_name) ASC"
    if @search = params[:search]
      @recipients = search_recipients(@search).order(order)
    else 
      @recipients = Recipient.order(order)
    end
  end

  # GET /recipients/1
  # GET /recipients/1.json
  def show
  end

  # GET /recipients/new
  def new
    @recipient = Recipient.new
  end

  # GET /recipients/1/edit
  def edit
  end

  # POST /recipients
  # POST /recipients.json
  def create
    @recipient = Recipient.new(recipient_params)

    respond_to do |format|
      if @recipient.save
        format.html { redirect_to @recipient, notice: 'Recipient was successfully created.' }
        format.json { render :show, status: :created, location: @recipient }
      else
        format.html { render :new }
        format.json { render json: @recipient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipients/1
  # PATCH/PUT /recipients/1.json
  def update
    respond_to do |format|
      if @recipient.update(recipient_params)
        format.html { redirect_to @recipient, notice: 'Recipient was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipient }
      else
        format.html { render :edit }
        format.json { render json: @recipient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipients/1
  # DELETE /recipients/1.json
  def destroy
    @recipient.destroy
    respond_to do |format|
      format.html { redirect_to recipients_url, notice: 'Recipient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def recipient_params
    params.require(:recipient).permit(:sca_name, :mundane_name, :is_group, :also_known_as, :formerly_known_as, :title, :pronouns)
  end

  def search_recipients(term)
    Recipient.where("mundane_name like :term or sca_name like :term or also_known_as like :term or formerly_known_as like :term", term: "%#{term}%")
  end
end
