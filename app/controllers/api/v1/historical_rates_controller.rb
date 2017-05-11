class Api
  class V1
    class HistoricalRatesController < ApplicationController
      before_action :set_historical_rate

      def show; end

      private

      def set_historical_rate
        @rate = HistoricalRate.find(params[:id])
      end
    end
  end
end
