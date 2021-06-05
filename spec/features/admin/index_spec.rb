require 'rails_helper'

RSpec.describe 'Admin' do
  it 'it shows admin dashboard' do
    # Admin Dashboard

    # As an admin,
    # When I visit the admin dashboard (/admin)
    # Then I see a header indicating that I am on the admin dashboard
    visit '/admin'

    expect(page).to have_content('Admin Dashboard')
  end

  it 'has links' do
    # Admin Dashboard Links
    # As an admin,
    # When I visit the admin dashboard (/admin)
    # Then I see a link to the admin merchants index (/admin/merchants)
    # And I see a link to the admin invoices index (/admin/invoices)
    visit '/admin'
    expect(page).to have_link('Merchants')
    click_link 'Merchants'
    expect(current_path).to eq('/admin/merchants')

    visit '/admin'
    expect(page).to have_link('Invoices')
    click_link 'Invoices'
    expect(current_path).to eq('/admin/invoices')
  end

  it "shows the top 5 customers" do
    # Admin Dashboard Statistics - Top Customers
    # As an admin,
    # When I visit the admin dashboard
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions
    # And next to each customer name I see the number of successful transactions they have
    # conducted
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

    visit '/admin'
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content("5")
    expect(page).to have_content(@customer_4.first_name)
    expect(page).to have_content("4")
    expect(page).to have_content(@customer_3.first_name)
    expect(page).to have_content("3")
    expect(page).to have_content(@customer_6.first_name)
    expect(page).to have_content("2")
    expect(page).to have_content(@customer_2.first_name)
    expect(page).to have_content("1")


    expect(@customer_1.first_name).to appear_before(@customer_4.first_name)
    expect(@customer_4.first_name).to appear_before(@customer_3.first_name)
    expect(@customer_3.first_name).to appear_before(@customer_6.first_name)
    expect(@customer_6.first_name).to appear_before(@customer_2.first_name)
  end

  it 'shows incomplete invoices' do
    @customer_1 = Customer.create!(first_name: "Dee", last_name: "Hill")
    @customer_2 = Customer.create!(first_name: "Zach", last_name: "Green")
    @customer_3 = Customer.create!(first_name: "Alex", last_name: "Ferencz")
    @customer_4 = Customer.create!(first_name: "Emmy", last_name: "Morris")
    @customer_5 = Customer.create!(first_name: "Lawrence", last_name: "Whalen")
    @merchant_1 = Merchant.create!(name: "Hot Topic")

    @invoice_1 = @customer_1.invoices.create!(status: :in_progress)
    @invoice_2 = @customer_1.invoices.create!(status: :in_progress)
    @invoice_3 = @customer_2.invoices.create!(status: :in_progress)
    @invoice_4 = @customer_2.invoices.create!(status: :in_progress)
    @invoice_5 = @customer_3.invoices.create!(status: :in_progress)
    @invoice_6 = @customer_3.invoices.create!(status: :in_progress)
    @invoice_7 = @customer_4.invoices.create!(status: :in_progress)
    @invoice_8 = @customer_4.invoices.create!(status: :in_progress)
    @invoice_9 = @customer_5.invoices.create!(status: :in_progress)
    @invoice_10 = @customer_5.invoices.create!(status: :in_progress)

    @item_1 = @merchant_1.items.create!(name: "Ding Dong", description: "edible dong", unit_price: 5)
    @item_2 = @merchant_1.items.create!(name: "Ointment", description: "lavender relaxing rub", unit_price: 4)
    @item_3 = @merchant_1.items.create!(name: "Umbrella", description: "weather protection", unit_price: 6)
    @item_4 = @merchant_1.items.create!(name: "Eggplant", description: "eating for perverts", unit_price: 1)
    @item_5 = @merchant_1.items.create!(name: "Butcher knife", description: "choppie choppie", unit_price: 8)
    @item_6 = @merchant_1.items.create!(name: "40oz water bottle", description: "hydration station", unit_price: 11)
    @item_7 = @merchant_1.items.create!(name: "Squidward nose", description: "holloween costume", unit_price: 99)
    @item_8 = @merchant_1.items.create!(name: "XL Sharpie", description: "inhalant", unit_price: 2)
    @item_9 = @merchant_1.items.create!(name: "Dragon", description: "aviation equipment", unit_price: 77)
    @item_10 = @merchant_1.items.create!(name: "Tall boy coke can", description: "soda ", unit_price: 44)

    @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_10, quantity: 4, unit_price: 2, status: 0)
    @invoice_item_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_9, quantity: 4, unit_price: 2, status: 1)
    @invoice_item_3 = InvoiceItem.create!(item: @item_3, invoice: @invoice_8, quantity: 4, unit_price: 2, status: 2) #s
    @invoice_item_4 = InvoiceItem.create!(item: @item_4, invoice: @invoice_7, quantity: 4, unit_price: 2, status: 0)
    @invoice_item_5 = InvoiceItem.create!(item: @item_5, invoice: @invoice_6, quantity: 4, unit_price: 2, status: 1)
    @invoice_item_6 = InvoiceItem.create!(item: @item_6, invoice: @invoice_5, quantity: 4, unit_price: 2, status: 2) #s
    @invoice_item_7 = InvoiceItem.create!(item: @item_7, invoice: @invoice_4, quantity: 4, unit_price: 2, status: 0)
    @invoice_item_8 = InvoiceItem.create!(item: @item_8, invoice: @invoice_3, quantity: 4, unit_price: 2, status: 1)
    @invoice_item_9 = InvoiceItem.create!(item: @item_9, invoice: @invoice_2, quantity: 4, unit_price: 2, status: 2) #s
    @invoice_item_10 = InvoiceItem.create!(item: @item_10, invoice: @invoice_1, quantity: 4, unit_price: 2, status: 0)
    visit '/admin'
    expect(page).to have_content("Incomplete Invoices")

    expect(page).to have_content(@invoice_10.id)
    expect(page).to have_link("Invoice #{@invoice_10.id}")
    click_link "Invoice #{@invoice_10.id}"
    expect(current_path).to eq("/admin/invoices/#{@invoice_10.id}")

    visit '/admin'

    expect(page).to have_content(@invoice_9.id)
    expect(page).to have_link("Invoice #{@invoice_9.id}")

    expect(page).to have_content(@invoice_7.id)
    expect(page).to have_link("Invoice #{@invoice_7.id}")

    expect(page).to have_content(@invoice_6.id)
    expect(page).to have_link("Invoice #{@invoice_6.id}")

    expect(page).to have_content(@invoice_4.id)
    expect(page).to have_link("Invoice #{@invoice_4.id}")

    expect(page).to have_content(@invoice_3.id)
    expect(page).to have_link("Invoice #{@invoice_3.id}")

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_link("Invoice #{@invoice_1.id}")

  end
end
