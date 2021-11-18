# frozen_string_literal: true

class HopsController < ApplicationController
  before_action :set_hop, only: %i[show edit update destroy]

  # GET /hops or /hops.json
  def index
    @hops = Hop.all
  end

  # GET /hops/1 or /hops/1.json
  def show; end

  # GET /hops/new
  def new
    @hop = Hop.new
  end

  # GET /hops/1/edit
  def edit; end

  # POST /hops or /hops.json
  def create
    @hop = Hop.new(hop_params)

    respond_to do |format|
      if @hop.save
        format.html { redirect_to @hop, notice: 'Hop was successfully created.' }
        format.json { render :show, status: :created, location: @hop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hops/1 or /hops/1.json
  def update
    respond_to do |format|
      if @hop.update(hop_params)
        format.html { redirect_to @hop, notice: 'Hop was successfully updated.' }
        format.json { render :show, status: :ok, location: @hop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hops/1 or /hops/1.json
  def destroy
    @hop.destroy
    respond_to do |format|
      format.html { redirect_to hops_url, notice: 'Hop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hop
    @hop = Hop.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def hop_params
    params.fetch(:hop, {})
  end
end
