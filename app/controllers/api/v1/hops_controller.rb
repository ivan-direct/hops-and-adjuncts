class Api::V1::HopsController < ApplicationController
  before_action :set_hop, only: %i[show edit update destroy]

  # GET /hops or /hops.json
  def index
    @hops = Hop.order(rating: :desc)
    render 'api/v1/hops/index.json.jbuilder'
  end

  # GET /hops/1 or /hops/1.json
  def show
    if @hop
      render json: @hop
    else
      render json: @hop.errors
    end
  end

  # GET /hops/new
  def new
    @hop = Hop.new
  end

  # GET /hops/1/edit
  def edit; end

  # POST /hops or /hops.json
  def create
    @hop = Hop.new(hop_params)

    if @hop.save
      render json: @hop
    else
      render json: @hop.errors
    end
  end

  # PATCH/PUT /hops/1 or /hops/1.json
  def update
    if @hop.update(hop_params)
      render json: { notice: 'Hop was updated successfully' }
    else
      format.json { render json: @hop.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /hops/1 or /hops/1.json
  def destroy
    @hop.destroy
    render json: { notice: 'Hop was successfully destroyed.' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hop
    @hop = Hop.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def hop_params
    params.fetch(:id, :name).permit
  end
end
