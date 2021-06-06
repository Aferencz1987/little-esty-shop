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

  it "endables/disables a merchant" do
    # Admin Merchant Enable/Disable
    # As an admin,
    # When I visit the admin merchants index
    # Then next to each merchant name I see a button to disable or enable that merchant.
    # When I click this button
    # Then I am redirected back to the admin merchants index
    # And I see that the merchant's status has changed

    @merchant_1 = Merchant.create!(name: 'H&M')

    visit '/admin/merchants'
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_button("Disable #{@merchant_1.name}")
    click_button "Disable #{@merchant_1.name}"

    expect(page).to have_content("Disabled")
    expect(page).to have_button("Enable #{@merchant_1.name}")
    click_button "Enable #{@merchant_1.name}"
    expect(page).to have_content("Enabled")
    expect(page).to have_button("Disable #{@merchant_1.name}")
  end

  it 'groups enabled and disabled' do
    @merchant_1 = Merchant.create!(name: 'H&M', enabled: true)
    @merchant_2 = Merchant.create!(name: 'Bubble', enabled: true)
    @merchant_3 = Merchant.create!(name: 'Pop', enabled: true)
    @merchant_4 = Merchant.create!(name: 'Egg', enabled: false)

    visit '/admin/merchants'

    within '.enabled' do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
    end

    within '.disabled' do
      expect(page).to have_content(@merchant_4.name)
    end
  end
end
