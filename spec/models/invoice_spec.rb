require 'rails_helper'

describe Invoice do
  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :transactions}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'inclomete hco;j co;' do
    it "sorted incomplete invoices by date" do
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
      expect(Invoice.incomplete_invoices_sorted_by_date.first.id).to eq(@invoice_1.id)
    end
  end
end
