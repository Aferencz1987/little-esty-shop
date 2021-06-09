class RemoveInvoiceMerchantId < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :merchant_id, :bigint  
  end
end
