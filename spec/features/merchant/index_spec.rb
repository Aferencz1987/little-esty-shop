require 'rails_helper'

RSpec.describe 'merchants' do 
  before(:each) do 
    @merchant = Merchant.create!(name: 'H&M')
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

      @customer_1 = Customer.create!(first_name: "Dee", last_name: "Hill")
      @customer_2 = Customer.create!(first_name: "Zach", last_name: "Green")
      @customer_3 = Customer.create!(first_name: "Alex", last_name: "Ferencz")
      @customer_4 = Customer.create!(first_name: "Emmy", last_name: "Morris")
      @customer_5 = Customer.create!(first_name: "Brian", last_name: "Zanti")
      @customer_6 = Customer.create!(first_name: "Jamison", last_name: "Ordway")
      @customer_7 = Customer.create!(first_name: "Lawrence", last_name: "Whalen")

      @invoice_1 = @customer_1.invoices.create!(status: :in_progress, merchant_id: @merchant.id)
      @transaction_1 = @invoice_1.transactions.create!(credit_card_number: "1234 5678 1234 2678", credit_card_expiration_date: nil, result: 0)
      @transaction_2 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
      @transaction_3 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
      @transaction_4 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
      @transaction_5 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
      @transaction_6 = @invoice_1.transactions.create!(credit_card_number: "1234 4321 1234 4321", credit_card_expiration_date: nil, result: 1)

      @invoice_2 = @customer_2.invoices.create!(status: :in_progress, merchant_id: @merchant.id)
      @transaction_7 = @invoice_2.transactions.create!(credit_card_number: "1234 5678 9012 3456", credit_card_expiration_date: nil, result: 1)
      @transaction_8 = @invoice_2.transactions.create!(credit_card_number: "4321 1234 4321 1234", credit_card_expiration_date: nil, result: 0)

      @invoice_3 = @customer_3.invoices.create!(status: :in_progress, merchant_id: @merchant.id)
      @transaction_9 = @invoice_3.transactions.create!(credit_card_number: "2345 5432 2345 5432", credit_card_expiration_date: nil, result: 0)
      @transaction_10 = @invoice_3.transactions.create!(credit_card_number: "2345 5432 2345 5432", credit_card_expiration_date: nil, result: 0)
      @transaction_11 = @invoice_3.transactions.create!(credit_card_number: "2345 5432 2345 5432", credit_card_expiration_date: nil, result: 0)

      @invoice_4 = @customer_4.invoices.create!(status: :in_progress, merchant_id: @merchant.id)
      @transaction_12 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
      @transaction_13 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
      @transaction_14 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
      @transaction_15 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
      @transaction_16 = @invoice_4.transactions.create!(credit_card_number: "7654 4567 7654 4567", credit_card_expiration_date: nil, result: 1)

      @invoice_5 = @customer_5.invoices.create!(status: :in_progress, merchant_id: @merchant.id)
      @transaction_17 = @invoice_5.transactions.create!(credit_card_number: "5432 2345 5432 2345", credit_card_expiration_date: nil, result: 1)

      @invoice_6 = @customer_6.invoices.create!(status: :in_progress, merchant_id: @merchant.id)
      @transaction_18 = @invoice_6.transactions.create!(credit_card_number: "6543 3456 6543 3456", credit_card_expiration_date: nil, result: 0)
      @transaction_19 = @invoice_6.transactions.create!(credit_card_number: "6543 3456 6543 3456", credit_card_expiration_date: nil, result: 0)

      visit merchant_dashboard_index_path(@merchant)
      
      # expect(page).to have_content(@customer_1.transaction_count)
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_2.first_name)
      expect(page).to have_content(@customer_3.first_name)
      expect(page).to have_content(@customer_4.first_name)
      # expect(page).to have_content(@customer_5.first_name)
      
      # expect(page).to_not have_content(@customer_6.first_name)
      # expect(page).to_not have_content(@customer_7.first_name)
    end

    xit 'shows the customer amount of successful trancations' do

      visit merchant_dashboard_index_path(@merchant)

    end
  end
end