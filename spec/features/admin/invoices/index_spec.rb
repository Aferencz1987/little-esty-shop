require 'rails_helper'

RSpec.describe 'Admin Invoice' do
  before(:each) do
    @merchant = Merchant.create!(name: 'H&M')
    @merchant_2 = Merchant.create!(name: 'Hot Topic')
    @customer = Customer.create!(first_name: "Dee", last_name: "Hill")

    @item_1 = Item.create!(name: 'Shoes', description: 'For your feet', unit_price: 10.0, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4, merchant_id: @merchant.id)
    @item_3 = Item.create!(name: 'Shorts', description: 'For basketball', unit_price: 11.2, merchant_id: @merchant_2.id)
    @item_4 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4, merchant_id: @merchant_2.id)

    @invoice_1 = @customer.invoices.create!(status: 1, merchant_id: @merchant.id)
    @invoice_2 = @customer.invoices.create!(status: 1, merchant_id: @merchant.id)
    @invoice_3 = @customer.invoices.create!(status: 1, merchant_id: @merchant.id)
    @invoice_4 = @customer.invoices.create!(status: 1, merchant_id: @merchant.id)

    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 14.9, status: 1, invoice_id: @invoice_2.id, item_id: @item_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_3.id, item_id: @item_3.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_4.id, item_id: @item_4.id)
  end

  it 'it shows admin invoice index' do
    # Admin Invoices Index Page
    # As an admin,
    # When I visit the admin Invoices index ("/admin/invoices")
    # Then I see a list of all Invoice ids in the system
    # Each id links to the admin invoice show page
    visit "/admin/invoices"
    save_and_open_page
    expect(page).to have_link("#{@invoice_1.id}")
    expect(page).to have_link("#{@invoice_2.id}")
    expect(page).to have_link("#{@invoice_3.id}")
    expect(page).to have_link("#{@invoice_4.id}")
    click_link "#{@invoice_4.id}"
    expect(current_path).to eq("/admin/invoices/#{@invoice_4.id}")
  end
end
