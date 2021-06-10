require 'rails_helper'

describe Merchant do
  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'instance methods' do
    it 'returns top 5 customers name' do

      @merchant = Merchant.create!(name: 'H&M')
      @customer_1 = Customer.create!(first_name: "Dee", last_name: "Hill")
      @customer_2 = Customer.create!(first_name: "Zach", last_name: "Green")
      @customer_3 = Customer.create!(first_name: "Alex", last_name: "Ferencz")
      @customer_4 = Customer.create!(first_name: "Emmy", last_name: "Morris")
      @customer_5 = Customer.create!(first_name: "Brian", last_name: "Zanti")
      @customer_6 = Customer.create!(first_name: "Jamison", last_name: "Ordway")

      @invoice_1 = @customer_1.invoices.create!(status: :in_progress)
      @transaction_1 = @invoice_1.transactions.create!(credit_card_number: "1234 5678 1234 2678", credit_card_expiration_date: nil, result: 0)
      @transaction_2 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
      @transaction_3 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
      @transaction_4 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
      @transaction_5 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
      @transaction_6 = @invoice_1.transactions.create!(credit_card_number: "1234 4321 1234 4321", credit_card_expiration_date: nil, result: 1)

      @invoice_2 = @customer_2.invoices.create!(status: :in_progress)
      @transaction_7 = @invoice_2.transactions.create!(credit_card_number: "1234 5678 9012 3456", credit_card_expiration_date: nil, result: 1)
      @transaction_8 = @invoice_2.transactions.create!(credit_card_number: "4321 1234 4321 1234", credit_card_expiration_date: nil, result: 0)

      @invoice_3 = @customer_3.invoices.create!(status: :in_progress)
      @transaction_9 = @invoice_3.transactions.create!(credit_card_number: "2345 5432 2345 5432", credit_card_expiration_date: nil, result: 0)
      @transaction_10 = @invoice_3.transactions.create!(credit_card_number: "2345 5432 2345 5432", credit_card_expiration_date: nil, result: 0)
      @transaction_11 = @invoice_3.transactions.create!(credit_card_number: "2345 5432 2345 5432", credit_card_expiration_date: nil, result: 0)

      @invoice_4 = @customer_4.invoices.create!(status: :in_progress)
      @transaction_12 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
      @transaction_13 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
      @transaction_14 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
      @transaction_15 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
      @transaction_16 = @invoice_4.transactions.create!(credit_card_number: "7654 4567 7654 4567", credit_card_expiration_date: nil, result: 1)

      @invoice_5 = @customer_5.invoices.create!(status: :in_progress)
      @transaction_17 = @invoice_5.transactions.create!(credit_card_number: "5432 2345 5432 2345", credit_card_expiration_date: nil, result: 1)

      @invoice_6 = @customer_6.invoices.create!(status: :in_progress)
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

      expected_customers = [@customer_1.first_name, @customer_4.first_name, @customer_3.first_name, @customer_6.first_name, @customer_2.first_name]

      actual_customers = @merchant.top_five_customers.map do |customer|
        customer.first_name
      end
      expect(actual_customers).to eq(expected_customers)
    end

    it 'groups enabled' do
      @merchant_1 = Merchant.create!(name: 'H&M', enabled: true)
      @merchant_2 = Merchant.create!(name: 'Bubble', enabled: true)
      @merchant_3 = Merchant.create!(name: 'Pop', enabled: true)
      @merchant_4 = Merchant.create!(name: 'Egg', enabled: false)

      expect(Merchant.group_by_enabled).to eq([@merchant_1, @merchant_2, @merchant_3])
    end

    it 'groups disabled' do
      @merchant_1 = Merchant.create!(name: 'H&M', enabled: true)
      @merchant_2 = Merchant.create!(name: 'Bubble', enabled: true)
      @merchant_3 = Merchant.create!(name: 'Pop', enabled: true)
      @merchant_4 = Merchant.create!(name: 'Egg', enabled: false)

      expect(Merchant.group_by_disabled).to eq([@merchant_4])
    end
  end
end
