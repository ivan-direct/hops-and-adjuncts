# frozen_string_literal: true

module Api
  module V1
    # The primary backend for the Hops React page
    class HopsController < ApplicationController
      before_action :set_hop, only: %i[show edit update destroy]

      # GET /hops or /hops.json
      def index
        @hops = if hop_params[:query].present?
                  Hop.where(name: hop_params[:query]).order(rating: :desc)
                else
                  Hop.order(rating: :desc)
                end
        render 'api/v1/hops/index', formats: :json
      rescue StandardError => e
        render_system_error e.message
      end

      # GET /hops/1 or /hops/1.json
      def show
        render 'api/v1/hops/show', formats: :json
      end

      # GET /hops/featured or /hops/featured.json
      def featured
        @hop = Hop.where(featured: true).sample
        if @hop.present?
          render 'api/v1/hops/show', formats: :json
        else
          render_not_found_error "Couldn't find Featured Hop"
        end
      end

      # GET /hops/popular or /hops/popular.json
      def popular
        @hops = Hop.popular
        render 'api/v1/hops/index', formats: :json
      rescue StandardError => e
        render_system_error e.message
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_hop
        @hop = Hop.find(hop_params[:id])
      rescue StandardError => e
        render_system_error e.message
      end

      # Only allow a list of trusted parameters through.
      def hop_params
        params.permit(:id, :query)
      end
    end
  end
end
