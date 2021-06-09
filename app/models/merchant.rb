class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_five_customers
      self.transactions.joins(invoice: :customer)
      .where('transactions.result = ?', 0)
      .select('customers.first_name, count(transactions) as successful_transactions')
      .group('customers.id')
      .order('successful_transactions desc')
      .limit(5)
  end

  def self.group_by_enabled
    where(enabled: true)
  end
  def self.group_by_disabled
    where(enabled: false)
  end

  def self.top_five_by_revenue
    joins(items: :invoice_items)
    .joins('JOIN transactions ON invoice_items.invoice_id = transactions.invoice_id')
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .where('transactions.result = 0')
    .group('merchants.id')
    .order('revenue desc')
    .limit(5)
  end
  #
  # def best_day
  #   joins(items: :invoice_items)
  #   .joins('JOIN transactions ON invoice_items.invoice_id = transactions.invoice_id')
  #   .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue' )
  #
  # end
end
