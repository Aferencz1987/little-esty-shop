class AdminController < ApplicationController
  def index
    @top_5 = Customer.successful_transactions
    @incomplete_invoices = Invoice.incomplete_invoices_sorted_by_date
    
  end
end
