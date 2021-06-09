require 'rails_helper'

RSpec.describe 'Merchant Invoice' do
  before(:each) do
    @merchant = Merchant.create!(name: 'H&M')  
    @merchant_2 = Merchant.create!(name: 'Hot Topic')
    @customer = Customer.create!(first_name: "Dee", last_name: "Hill")

    @item_1 = Item.create!(name: 'Shoes', description: 'For your feet', unit_price: 10.0)
    @item_2 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4)
    @item_3 = Item.create!(name: 'Shorts', description: 'For basketball', unit_price: 11.2)
    @item_4 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4)
    
    @invoice_1 = @customer.invoices.create!(status: 1)
    @invoice_2 = @customer.invoices.create!(status: 1)
    @invoice_3 = @customer.invoices.create!(status: 1)
    @invoice_4 = @customer.invoices.create!(status: 1)
    
    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id) 
    @invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 14.9, status: 1, invoice_id: @invoice_2.id, item_id: @item_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_3.id, item_id: @item_3.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_4.id, item_id: @item_4.id)
  end

    #Merchant Invoice Story 1
  it 'visits the Merchant invocie index' do
    visit "/merchants/#{@merchant.id}/invoices"

    expect(page).to have_content('Merchant Invoices')
    
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
    expect(page).to have_content(@invoice_3.id)
    expect(page).to have_content(@invoice_4.id)

    expect(page).to have_link("#{@invoice_1.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")
    expect(page).to have_link("#{@invoice_2.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice_2.id}")
    expect(page).to have_link("#{@invoice_3.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice_3.id}")
    expect(page).to have_link("#{@invoice_4.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice_4.id}")
  end    
end