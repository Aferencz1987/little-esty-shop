class InvoiceItem < ApplicationRecord
  enum status: [:packaged, :pending, :shipped]
  belongs_to :invoice
  belongs_to :item

  def total_revenue
    self.sum(unit_price * quantity)
  end

  
end
