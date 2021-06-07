require 'rails_helper'

RSpec.describe 'Merchant Invoice' do
  before(:each) do
    @merchant = Merchant.create!(name: 'H&M')  
    @merchant_2 = Merchant.create!(name: 'Hot Topic')
    @customer = Customer.create!(first_name: "Dee", last_name: "Hill")

    @item_1 = Item.create!(name: 'Shoes', description: 'For your feet', unit_price: 10.0, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4, merchant_id: @merchant.id)
    @item_3 = Item.create!(name: 'Shorts', description: 'For basketball', unit_price: 11.2, merchant_id: @merchant_2.id)
    @item_4 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4, merchant_id: @merchant_2.id)
    
    @invoice_1 = Invoices.create!(status: 1, merchant_id: @customer.id)
    @invoice_2 = Invoices.create!(status: 1, merchant_id: @customer.id)
    @invoice_3 = Invoices.create!(status: 1, merchant_id: @customer.id)
    @invoice_4 = Invoices.create!(status: 1, merchant_id: @customer.id)
    
    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id) 
    @invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 14.9, status: 1, invoice_id: @invoice_2.id, item_id: @item_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_3.id, item_id: @item_3.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_4.id, item_id: @item_4.id)
  end

    # As a merchant,
    # When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
    # Then I see all of the invoices that include at least one of my merchant's items
    # And for each invoice I see its id
    # And each id links to the merchant invoice show page
  it 'visits the Merchant invocie index' do
    visit merchant_invoices(@merchant)

    expect(page).to have_content('Merchant Invoices')
    
  end    
end