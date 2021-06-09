class Customer < ApplicationRecord
  has_many :invoices

  def self.successful_transactions
    joins(invoices: :transactions)
    .where("transactions.result = 0")
    .select("customers.*, count(transactions.result) as transaction_count")
    .order("transaction_count desc", :first_name)
    .group(:id)
    .limit(5)
  end

  def self.customer_merchants(merchant)
    invoices.joins(:transactions, [items: :merchant])
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .where('transactions.result = 0')
    .group('merchants.id')
    .order('revenue')
  end
end
