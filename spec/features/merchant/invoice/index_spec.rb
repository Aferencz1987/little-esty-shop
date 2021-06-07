require 'rails_helper'

RSpec.describe 'Merchant Invoice' do
  before(:each) do
    @merchant = Merchant.create!(name: 'H&M')  
  end

    # As a merchant,
    # When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
    # Then I see all of the invoices that include at least one of my merchant's items
    # And for each invoice I see its id
    # And each id links to the merchant invoice show page
  it 'visits the Merchant invocie index' do
    visit merchant_invoices(@merchant)

    expect(page).to have_content()
  end    
end