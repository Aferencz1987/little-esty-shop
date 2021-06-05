require 'rails_helper'

RSpec.describe 'Admin Merchant' do
  it 'it shows admin merchant show' do
    # Admin Merchant Show
    # As an admin,
    # When I click on the name of a merchant from the admin merchants index page,
    # Then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)
    # And I see the name of that merchant
    @merchant = Merchant.create!(name: 'H&M')

    visit "/admin/merchants/#{@merchant.id}"

    expect(page).to have_content("Admin Merchant: #{@merchant.name}")
    expect(page).to have_content(@merchant.name)
    expect(page).to have_link("Update #{@merchant.name}")
    click_link "Update #{@merchant.name}"
    expect(current_path).to eq("/admin/merchants/#{@merchant.id}/edit")
  end
end
