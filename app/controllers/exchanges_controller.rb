class ExchangesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_exchange, only: %i[edit update destroy show]

  def index
    @exchanges = Exchange.all
  end

  def new
    @exchange = Exchange.new
  end

  def create
    @exchange = Exchange.new(exchange_params)
    @exchange.user_id = current_user.id

    if @exchange.save
      redirect_to @exchange
    else
      render 'new'
    end
  end

  def show
    @exchange_order = Prediction.new(@exchange.amount,
                                     @exchange.base_currency,
                                     @exchange.target_currency,
                                     @exchange.waiting_time)
    @predictions = @exchange_order.final_prediction
    @top_three = @predictions.group_by { |item| item[:amount] }
                             .sort_by  { |key, _value| -key }
                             .first(3)
                             .map(&:last)
                             .flatten
  end

  def edit; end

  def update
    if @exchange.update(exchange_params)
      redirect_to @exchange
    else
      render 'edit'
    end
  end

  def destroy
    @exchange.destroy
    redirect_to exchanges_path
  end

  private

  def exchange_params
    params.require(:exchange)
          .permit(:amount,
                  :base_currency,
                  :target_currency,
                  :waiting_time,
                  :user_id)
  end

  def find_exchange
    @exchange = Exchange.find(params[:id])
  end
end
