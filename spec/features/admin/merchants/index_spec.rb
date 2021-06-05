require 'rails_helper'

RSpec.describe 'Admin Merchant' do
  it 'it shows admin merchant index' do
    # Admin Merchants Index
    #
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    # Then I see the name of each merchant in the system
    @merchant = Merchant.create!(name: 'H&M')

    visit '/admin/merchants'

    expect(page).to have_content('Admin Merchants')
    expect(page).to have_content(@merchant.name)
    expect(page).to have_link("#{@merchant.name}")
    click_link "#{@merchant.name}"
    expect(current_path).to eq("/admin/merchants/#{@merchant.id}")
  end
end
