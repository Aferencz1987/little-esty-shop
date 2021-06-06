require 'rails_helper'

RSpec.describe 'Admin Merchant' do
  it 'it shows admin merchant show' do
    # Admin Merchant Show
    # As an admin,
    # When I click on the name of a merchant from the admin merchants index page,
    # Then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)
    # And I see the name of that merchant
    # Admin Merchant Update

    # As an admin,
    # When I visit a merchant's admin show page
    # Then I see a link to update the merchant's information.
    # When I click the link
    # Then I am taken to a page to edit this merchant
    # And I see a form filled in with the existing merchant attribute information
    # When I update the information in the form and I click ‘submit’
    # Then I am redirected back to the merchant's admin show page where I see the updated information
    # And I see a flash message stating that the information has been successfully updated.
    @merchant = Merchant.create!(name: 'H&M')

    visit "/admin/merchants/#{@merchant.id}"

    expect(page).to have_content("Admin Merchant: #{@merchant.name}")
    expect(page).to have_content(@merchant.name)
    expect(page).to have_link("Update #{@merchant.name}")
    click_link "Update #{@merchant.name}"
    expect(current_path).to eq("/admin/merchants/#{@merchant.id}/edit")
    fill_in 'Name', with: 'Claires'
    click_button "Update #{@merchant.name}"
    expect(current_path).to eq("/admin/merchants/#{@merchant.id}")
    expect(page).to have_content("Merchant has been successfully updated")
  end
end
