class Invoice < ApplicationRecord
  enum status: [:cancelled, :in_progress, :completed]
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.incomplete_invoices_sorted_by_date
    joins(:invoice_items)
    .where("invoice_items.status != 2")
    .select("invoices.id, invoices.created_at")
    .order(:created_at)
    .distinct
  end
end
