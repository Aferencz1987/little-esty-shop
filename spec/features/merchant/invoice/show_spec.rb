require 'rails_helper'

RSpec.describe 'Merchant Invoice show page' do
    before(:each) do
      @merchant = Merchant.create!(name: 'H&M')  
      @merchant_2 = Merchant.create!(name: 'Hot Topic')
      @customer = Customer.create!(first_name: "Dee", last_name: "Hill")

      @item_1 = Item.create!(name: 'Shoes', description: 'For your feet', unit_price: 10.0, merchant_id: @merchant.id)
      @item_2 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4, merchant_id: @merchant.id)
      @item_3 = Item.create!(name: 'Shorts', description: 'For basketball', unit_price: 11.2, merchant_id: @merchant_2.id)
      @item_4 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4, merchant_id: @merchant_2.id)
    
      @invoice_1 = @customer.invoices.create!(status: 1, merchant_id: @merchant.id)
    
      @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id) 
      @invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_2.id)
      @invoice_item_3 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_3.id)
    end
    #   As a merchant
    # When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
    # Then I see information related to that invoice including:
    # - Invoice id
    # - Invoice status
    # - Invoice created_at date in the format "Monday, July 18, 2019"
    # - Customer first and last name  
    it 'shows an info related to tthe invoice' do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"     

      expect(page).to have_content("#{@invoice_1.id}")
      expect(page).to have_content("#{@invoice_1.status}")
      expect(page).to have_content("#{@invoice_1.id}")
      expect(page).to have_content("#{@customer.first_name}")
      expect(page).to have_content("#{@customer.last_name}")
    end  
end