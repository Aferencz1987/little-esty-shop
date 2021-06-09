require 'rails_helper'

RSpec.describe 'Admin Merchant' do
  before(:each) do
    @top_5 = Merchant.top_five_by_revenue
    @merchant_1 = Merchant.create!(name: 'H&M', enabled: true)
    @merchant_2 = Merchant.create!(name: 'Bubble', enabled: true)
    @merchant_3 = Merchant.create!(name: 'Pop', enabled: true)
    @merchant_4 = Merchant.create!(name: 'Egg', enabled: false)
    @merchant_5 = Merchant.create!(name: 'Cheese', enabled: true)
    @merchant_6 = Merchant.create!(name: 'Leaf', enabled: false)

    @customer = Customer.create!(first_name: "Dee", last_name: "Hill")

    @item_1 = Item.create!(name: 'Shoes', description: 'For your feet', unit_price: 10.0, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4, merchant_id: @merchant_2.id)
    @item_3 = Item.create!(name: 'Shorts', description: 'For basketball', unit_price: 11.2, merchant_id: @merchant_3.id)
    @item_4 = Item.create!(name: 'Dress', description: 'Ugly gown', unit_price: 12.4, merchant_id: @merchant_4.id)
    @item_5 = Item.create!(name: 'Dress', description: 'Beautiful gown', unit_price: 12.4, merchant_id: @merchant_5.id)

    @invoice_1 = @customer.invoices.create!(status: 1)
      @transaction_1 = @invoice_1.transactions.create!(credit_card_number: "1234 5678 1234 2678", credit_card_expiration_date: nil, result: 0)
      @transaction_2 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
      @transaction_3 = @invoice_1.transactions.create!(credit_card_number: "1234 1234 1234 1234", credit_card_expiration_date: nil, result: 0)
    @invoice_2 = @customer.invoices.create!(status: 1)
      @transaction_4 = @invoice_2.transactions.create!(credit_card_number: "1234 5678 9012 3456", credit_card_expiration_date: nil, result: 1)
      @transaction_5 = @invoice_2.transactions.create!(credit_card_number: "4321 1234 4321 1234", credit_card_expiration_date: nil, result: 0)

    @invoice_3 = @customer.invoices.create!(status: 1)
    @transaction_6 = @invoice_3.transactions.create!(credit_card_number: "2345 5432 2345 5432", credit_card_expiration_date: nil, result: 0)
    @transaction_7 = @invoice_3.transactions.create!(credit_card_number: "2345 5432 2345 5432", credit_card_expiration_date: nil, result: 0)
    @transaction_8 = @invoice_3.transactions.create!(credit_card_number: "2345 5432 2345 5432", credit_card_expiration_date: nil, result: 0)

    @invoice_4 = @customer.invoices.create!(status: 1)
    @transaction_9 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
    @transaction_10 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
    @transaction_11 = @invoice_4.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)

    @invoice_5 = @customer.invoices.create!(status: 1)
    @transaction_9 = @invoice_5.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
    @transaction_10 = @invoice_5.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)
    @transaction_11 = @invoice_5.transactions.create!(credit_card_number: "3456 6543 3456 6543", credit_card_expiration_date: nil, result: 0)

    @invoice_item_1 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 14.9, status: 1, invoice_id: @invoice_2.id, item_id: @item_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_3.id, item_id: @item_3.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_4.id, item_id: @item_4.id)
    @invoice_item_5 = InvoiceItem.create!(quantity: 2, unit_price: 14.9, status: 1, invoice_id: @invoice_5.id, item_id: @item_5.id)
  end

  it 'it shows admin merchant index' do
    # Admin Merchants Index
    #
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    # Then I see the name of each merchant in the system
    @merchant = Merchant.create!(name: 'TJ Max')

    visit '/admin/merchants'

    expect(page).to have_content('Admin Merchants')
    expect(page).to have_content(@merchant.name)
    expect(page).to have_link("#{@merchant.name}")
    click_link "#{@merchant.name}"
    expect(current_path).to eq("/admin/merchants/#{@merchant.id}")
  end

  it "endables/disables a merchant" do
    # Admin Merchant Enable/Disable
    # As an admin,
    # When I visit the admin merchants index
    # Then next to each merchant name I see a button to disable or enable that merchant.
    # When I click this button
    # Then I am redirected back to the admin merchants index
    # And I see that the merchant's status has changed

    @merchant_1 = Merchant.create!(name: 'Rogers')

    visit '/admin/merchants'
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_button("Disable #{@merchant_1.name}")
    click_button "Disable #{@merchant_1.name}"

    expect(page).to have_content("Disabled")
    expect(page).to have_button("Enable #{@merchant_1.name}")
    click_button "Enable #{@merchant_1.name}"
    expect(page).to have_content("Enabled")
    expect(page).to have_button("Disable #{@merchant_1.name}")
  end

  it 'groups enabled and disabled' do
    @merchant_1 = Merchant.create!(name: 'H&M', enabled: true)
    @merchant_2 = Merchant.create!(name: 'Bubble', enabled: true)
    @merchant_3 = Merchant.create!(name: 'Pop', enabled: true)
    @merchant_4 = Merchant.create!(name: 'Egg', enabled: false)
    visit '/admin/merchants'

    within '.enabled' do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
    end

    within '.disabled' do
      expect(page).to have_content(@merchant_4.name)
    end
  end

  it 'can show a created merchant' do
    # As an admin,
    # When I visit the admin merchants index
    # I see a link to create a new merchant.
    # When I click on the link,
    # I am taken to a form that allows me to add merchant information.
    # When I fill out the form I click ‘Submit’
    # Then I am taken back to the admin merchants index page
    # And I see the merchant I just created displayed
    # And I see my merchant was created with a default status of disabled.
    visit "/admin/merchants"

    expect(page).to have_link("Create Merchant")
    click_link "Create Merchant"
    expect(current_path).to eq("/admin/merchants/new")
    fill_in "Name", with: "Count Chocula's Chocolate Emporium"
    click_button "Save"
    expect(current_path).to eq("/admin/merchants")
    expect(Merchant.last.name).to eq("Count Chocula's Chocolate Emporium")
    expect(page).to have_content("Count Chocula's Chocolate Emporium")
    expect(page).to have_button("Enable Count Chocula's Chocolate Emporium")
  end

  it "Show top 5 merchants by total revenue generated" do
    # Admin Merchants: Top 5 Merchants by Revenue
    # As an admin,
    # When I visit the admin merchants index
    # Then I see the names of the top 5 merchants by total revenue generated
    # And I see that each merchant name links to the admin merchant show page for that merchant
    # And I see the total revenue generated next to each merchant name
    #
    # Notes on Revenue Calculation:
    # - Only invoices with at least one successful transaction should count towards revenue
    # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
    # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
    visit "/admin/merchants"
    expect(page).to have_link("#{@merchant_1.name}", href: "/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content(@top_5.first.revenue)

    expect(page).to have_link("#{@merchant_2.name}", href: "/admin/merchants/#{@merchant_2.id}")
    expect(page).to have_content(@top_5.second.revenue)

    expect(page).to have_link("#{@merchant_3.name}", href: "/admin/merchants/#{@merchant_3.id}")
    expect(page).to have_content(@top_5.third.revenue)

    expect(page).to have_link("#{@merchant_4.name}", href: "/admin/merchants/#{@merchant_4.id}")
    expect(page).to have_content(@top_5.fourth.revenue)

    within '.revenue' do
      expect(page).to have_link("#{@merchant_5.name}", href: "/admin/merchants/#{@merchant_5.id}")
      expect(page).to have_content(@top_5.fifth.revenue)
      click_link "#{@merchant_5.name}"
    end
    expect(current_path).to eq("/admin/merchants/#{@merchant_5.id}")
  end
end
