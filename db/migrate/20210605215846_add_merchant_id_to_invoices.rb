class AddMerchantIdToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :merchant_id, :bigint
  end
end
