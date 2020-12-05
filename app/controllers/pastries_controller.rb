class PastriesController < ApplicationController
  def index
    @pastries = Pastry.all
  end

  def order
    code = params[:code]
    order = params[:order]
    @my_order = PastryService.configure_order(code, order)
    render "order", :layout => false
    # render json: @my_order
  end
end
