# frozen_string_literal: true

module Api
  module V1
    # The primary backend for the Adjuncts React page
    class AdjunctsController < ApplicationController
      before_action :set_adjunct, only: %i[show]

      # GET /adjuncts or /adjuncts.json
      def index
        query = adjunct_params[:query]
        @adjuncts = Adjunct.search(query)
        render 'api/v1/adjuncts/index', formats: :json
      rescue StandardError => e
        render_system_error e.message
      end

      # GET /adjuncts/1 or /adjuncts/1.json
      def show
        render 'api/v1/adjuncts/show', formats: :json
      end

      # GET /adjuncts/featured or /adjuncts/featured.json
      def featured
        @adjunct = Adjunct.where(featured: true).sample
        if @adjunct.present?
          render 'api/v1/adjuncts/show', formats: :json
        else
          render_not_found_error "Couldn't find Featured Adjunct"
        end
      end

      # GET /adjuncts/popular or /adjuncts/popular.json
      def popular
        @adjuncts = Adjunct.popular
        render 'api/v1/adjuncts/index', formats: :json
      rescue StandardError => e
        render_system_error e.message
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_adjunct
        @adjunct = Adjunct.find(adjunct_params[:id])
      rescue StandardError => e
        render_system_error e.message
      end

      # Only allow a list of trusted parameters through.
      def adjunct_params
        params.permit(:id, :query)
      end
    end
  end
end
