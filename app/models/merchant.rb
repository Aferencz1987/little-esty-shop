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
end
