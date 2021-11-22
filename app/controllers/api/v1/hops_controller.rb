# frozen_string_literal: true

module Api
  module V1
    class HopsController < ApplicationController
      before_action :set_hop, only: %i[show edit update destroy]

      # GET /hops or /hops.json
      def index
        @hops = if params[:query].present?
                  Hop.where(name: params[:query]).order(rating: :desc)
                else
                  Hop.order(rating: :desc)
                end
        render 'api/v1/hops/index', formats: :json
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
        params.fetch(:id, :name, :query).permit
      end
    end
  end
end
