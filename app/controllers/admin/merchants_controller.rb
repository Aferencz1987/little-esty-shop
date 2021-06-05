class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    if @merchant.save
      redirect_to "/admin/merchants/#{@merchant.id}",
      error: "Merchant has been successfully updated"
      # flash[:success] = "Merchant has been successfully updated"
    end
  end

  private
  def merchant_params
    params.permit(:name)
  end
end
