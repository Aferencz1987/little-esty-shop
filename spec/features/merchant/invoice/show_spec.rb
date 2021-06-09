require 'rails_helper'

RSpec.describe 'Merchant Invoice show page' do
    before(:each) do
      @merchant = Merchant.create!(name: 'H&M')  
      @merchant_2 = Merchant.create!(name: 'Hot Topic')
      @customer = Customer.create!(first_name: "Dee", last_name: "Hill")

      @item_1 = @merchant.items.create!(name: 'Shoes', description: 'For your feet', unit_price: 10.0)
      @item_2 = @merchant.items.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4)
      @item_3 = @merchant.items.create!(name: 'Shorts', description: 'For basketball', unit_price: 11.2)
      @item_4 = @merchant.items.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4)
    
      @invoice_1 = @customer.invoices.create!(status: 1)
    
      @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id) 
      @invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_2.id)
      @invoice_item_3 = InvoiceItem.create!(quantity: 7, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_3.id)
    end
    
    # Merchant Invoice Story 2  
    it 'shows an info related to tthe invoice' do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"     

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@customer.first_name)
      expect(page).to have_content(@customer.last_name)
    end
    
     # Merchant Invoice Story 3
    it 'shows all the items on the invoice show page with attributes including Invoice Item quatity and status' do 
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"
      
      expect(page).to have_content('Items')

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@invoice_item_1.quantity)
      expect(page).to have_content(@invoice_item_1.unit_price)
      expect(page).to have_content(@invoice_item_1.status)
      
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@invoice_item_2.quantity)
      expect(page).to have_content(@invoice_item_2.unit_price)
      expect(page).to have_content(@invoice_item_2.status)

      # expect(page).to_not have_content(@item_3.name)
      # expect(page).to_not have_content(@item_4.name)
    end
end