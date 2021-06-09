require 'rails_helper'

RSpec.describe 'Admin Invoice show page' do
  before(:each) do
    @merchant = Merchant.create!(name: 'H&M')
    @merchant_2 = Merchant.create!(name: 'Hot Topic')
    @customer = Customer.create!(first_name: "Dee", last_name: "Hill")

    @item_1 = Item.create!(name: 'Shoes', description: 'For your feet', unit_price: 10.0, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4, merchant_id: @merchant.id)
    @item_3 = Item.create!(name: 'Shorts', description: 'For basketball', unit_price: 11.2, merchant_id: @merchant_2.id)
    @item_4 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4, merchant_id: @merchant_2.id)

    @invoice_1 = @customer.invoices.create!(status: 1)
    @invoice_2 = @customer.invoices.create!(status: 1)
    @invoice_3 = @customer.invoices.create!(status: 1)
    @invoice_4 = @customer.invoices.create!(status: 1)

    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 14.9, status: 1, invoice_id: @invoice_2.id, item_id: @item_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_3.id, item_id: @item_3.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_4.id, item_id: @item_4.id)
  end

  it 'it shows admin invoice show' do
    # Admin Invoice Show Page
    # As an admin,
    # When I visit an admin invoice show page
    # Then I see information related to that invoice including:
    # - Invoice id
    # - Invoice status
    # - Invoice created_at date in the format "Monday, July 18, 2019"
    # - Customer first and last name
    visit "/admin/invoices/#{@invoice_4.id}"
    expect(page).to have_content("Invoice id: #{@invoice_4.id}")
    expect(page).to have_content("Status: #{@invoice_4.status}")
    expect(page).to have_content("Created at: #{@invoice_4.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer: #{@customer.first_name} #{@customer.last_name}")
  end
end
