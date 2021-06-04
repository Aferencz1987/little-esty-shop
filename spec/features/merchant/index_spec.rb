require 'rails_helper'

RSpec.describe 'merchants' do 
  before(:each) do 
    @merchant = Merchant.create!(name: 'H&M')
  end

  describe 'Merchant Dash' do
    # Merchant Story 1 
    it 'visits the Merchant Dashboard' do
      visit merchant_dashboard_index_path(@merchant)
      
      expect(page).to have_content('Merchant Dashboard')
      expect(page).to have_content(@merchant.name)
    end
    
    # As a merchant,
    # When I visit my merchant dashboard
    # Then I see link to my merchant items index (/merchants/merchant_id/items)
    # And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
    it 'has links on the Merchant Dashboard' do  
      visit merchant_dashboard_index_path(@merchant)
      
      expect(page).to have_link('Items')
      expect(page).to have_link('Invoices')
    end
  end
end