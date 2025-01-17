require 'rails_helper'

RSpec.describe 'merchants' do
  before(:each) do
    @merchant = Merchant.create!(name: 'H&M')

    @customer_1 = Customer.create!(first_name: "Dee", last_name: "Hill")
    @customer_2 = Customer.create!(first_name: "Zach", last_name: "Green")
    @customer_3 = Customer.create!(first_name: "Alex", last_name: "Ferencz")
    @customer_4 = Customer.create!(first_name: "Emmy", last_name: "Morris")
    @customer_5 = Customer.create!(first_name: "Brian", last_name: "Zanti")
    @customer_6 = Customer.create!(first_name: "Jamison", last_name: "Ordway")
    @customer_7 = Customer.create!(first_name: "Lawrence", last_name: "Whalen")
    
    @invoice_1 = @customer_1.invoices.create!(status: :in_progress, created_at: 'Wed, 09 Jun 2021 01:37:38 UTC +00:00')
    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: "1234 5678 1234 2678", credit_card_expiration_date: nil, result: 0)
    @transaction_2 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
    @transaction_3 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
    @transaction_4 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
    @transaction_5 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
    @transaction_6 = @invoice_1.transactions.create!(credit_card_number: "1234 4321 1234 4321", credit_card_expiration_date: nil, result: 1)

    @invoice_2 = @customer_2.invoices.create!(status: :in_progress, created_at: 'Tue, 08 Jun 2021 01:20:38 UTC +00:00')
    @transaction_7 = @invoice_2.transactions.create!(credit_card_number: "1234 5678 9012 3456", credit_card_expiration_date: nil, result: 1)
    @transaction_8 = @invoice_2.transactions.create!(credit_card_number: "4321 1234 4321 1234", credit_card_expiration_date: nil, result: 0)

    @invoice_3 = @customer_3.invoices.create!(status: :in_progress, created_at: 'Mon, 07 Jun 2021 01:35:38 UTC +00:00')
    @transaction_9 = @invoice_3.transactions.create!(credit_card_number: "2345 5432 2345 5432", credit_card_expiration_date: nil, result: 0)
    @transaction_10 = @invoice_3.transactions.create!(credit_card_number: "2345 5432 2345 5432", credit_card_expiration_date: nil, result: 0)
    @transaction_11 = @invoice_3.transactions.create!(credit_card_number: "2345 5432 2345 5432", credit_card_expiration_date: nil, result: 0)

    @invoice_4 = @customer_4.invoices.create!(status: :in_progress, created_at: 'Sun, 06 Jun 2021 02:37:38 UTC +00:00')
    @transaction_12 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
    @transaction_13 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
    @transaction_14 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
    @transaction_15 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
    @transaction_16 = @invoice_4.transactions.create!(credit_card_number: "7654 4567 7654 4567", credit_card_expiration_date: nil, result: 1)

    @invoice_5 = @customer_5.invoices.create!(status: :in_progress, created_at: 'Sat, 05 Jun 2021 01:37:29 UTC +00:00')
    @transaction_17 = @invoice_5.transactions.create!(credit_card_number: "5432 2345 5432 2345", credit_card_expiration_date: nil, result: 1)

    @invoice_6 = @customer_6.invoices.create!(status: :in_progress, created_at: 'Fri, 04 Jun 2021 01:37:30 UTC +00:00')
    @transaction_18 = @invoice_6.transactions.create!(credit_card_number: "6543 3456 6543 3456", credit_card_expiration_date: nil, result: 0)
    @transaction_19 = @invoice_6.transactions.create!(credit_card_number: "6543 3456 6543 3456", credit_card_expiration_date: nil, result: 0)

    @item_1 = Item.create!(name: 'Shoes', description: 'For your feet', unit_price: 10.0, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4, merchant_id: @merchant.id)
    @item_3 = Item.create!(name: 'Shorts', description: 'For basketball', unit_price: 11.2, merchant_id: @merchant.id)
    @item_4 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4, merchant_id: @merchant.id)

    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 10.0, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 12.4, status: 1, invoice_id: @invoice_2.id, item_id: @item_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 7, unit_price: 11.2, status: 1, invoice_id: @invoice_3.id, item_id: @item_3.id)

    @invoice_item_4 = InvoiceItem.create!(quantity: 12, unit_price: 10.0, status: 1, invoice_id: @invoice_4.id, item_id: @item_1.id)
    @invoice_item_5 = InvoiceItem.create!(quantity: 7, unit_price: 12.4, status: 1, invoice_id: @invoice_5.id, item_id: @item_2.id)
    @invoice_item_6 = InvoiceItem.create!(quantity: 19, unit_price: 12.4, status: 1, invoice_id: @invoice_6.id, item_id: @item_4.id)
  end

  describe 'Merchant Dash' do
    # Merchant Dash Story 1
    it 'visits the Merchant Dashboard' do
      visit merchant_dashboard_index_path(@merchant)

      expect(page).to have_content('Merchant Dashboard')
      expect(page).to have_content(@merchant.name)
    end

    # Merchant Dash Story 2
    it 'has links on the Merchant Dashboard' do
      visit merchant_dashboard_index_path(@merchant)

      expect(page).to have_link('Items')

      # click_link 'Items'

      # expect(current_path).to eq("/merchants/#{@item.id}/invoices")

      visit merchant_dashboard_index_path(@merchant)

      expect(page).to have_link('Invoices')

      click_link 'Invoices'

      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    end

    # Merchant Dash Story 3
    it 'shows the top 5 customers who conducted the most successful transactions' do



      visit merchant_dashboard_index_path(@merchant)

      # expect(page).to have_content(@customer_1.transaction_count)
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_2.first_name)
      expect(page).to have_content(@customer_3.first_name)
      expect(page).to have_content(@customer_4.first_name)
      expect(page).to have_content(@customer_6.first_name)

      # expect(page).to_not have_content(@customer_6.first_name)
      # expect(page).to_not have_content(@customer_7.first_name)
    end

    xit 'shows the customer amount of successful trancations' do

      visit merchant_dashboard_index_path(@merchant)

    end

      # Merchant Dashboard Item Created at Story
    it 'shows item created date and sorts oldest to newest' do
      visit merchant_dashboard_index_path(@merchant)

      expect(page).to have_content('Items Ready to Ship')
      
      
      expect(page).to have_content("#{@item_1.name}, Created at:#{@item_1.invoices.first.convert_time}")
      expect(page).to have_content("#{@item_2.name}, Created at:#{@item_2.invoices.first.convert_time}")
      expect(page).to have_content("#{@item_3.name}, Created at:#{@item_3.invoices.first.convert_time}")
      expect(page).to have_content("#{@item_4.name}, Created at:#{@item_4.invoices.first.convert_time}")
      
      expect(@item_1.name).to appear_before(@item_2.name)
      expect(@item_2.name).to appear_before(@item_3.name)
      expect(@item_4.name).to_not appear_before(@item_1.name)
    end
  end
end
