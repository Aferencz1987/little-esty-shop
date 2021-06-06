require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it {should have_many :invoices}
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns ' do
        @customer_1 = Customer.create!(first_name: "Dee", last_name: "Hill")
        @customer_2 = Customer.create!(first_name: "Zach", last_name: "Green")
        @customer_3 = Customer.create!(first_name: "Alex", last_name: "Ferencz")
        @customer_4 = Customer.create!(first_name: "Emmy", last_name: "Morris")
        @customer_5 = Customer.create!(first_name: "Brian", last_name: "Zanti")
        @customer_6 = Customer.create!(first_name: "Jamison", last_name: "Ordway")
        @customer_7 = Customer.create!(first_name: "Lawrence", last_name: "Whalen")

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

        expect(Customer.successful_transactions).to eq([@customer_1, @customer_4, @customer_3, @customer_6, @customer_2 ])
      end
    end
  end
end
