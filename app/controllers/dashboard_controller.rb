class DashboardController < ApplicationController
  def index
    @merchant = Merchant.all
  end
end