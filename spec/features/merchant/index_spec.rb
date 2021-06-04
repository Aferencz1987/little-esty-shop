require 'rails_helper'

RSpec.describe 'merchants' do 
  before(:each) do 
    @merchant = Merchant.create!(name: 'H&M')
  end

  # Merchant Story 1 
  it 'visits the Merchant Dashboard' do
    visit merchant_dashboard_index_path(@merchant)
    
    expect(page).to have_content(@merchant.name)
  end
end