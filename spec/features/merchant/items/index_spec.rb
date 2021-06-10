
# As a merchant,
# When I visit my merchant items index page ("merchants/merchant_id/items")
# I see a list of the names of all of my items
# And I do not see items for any other merchant
describe 'merchant item index' do
  it "displays a list of the names of the items" do
    @merchant = Merchant.create!(name: 'Ryan')
    item1 = @merchant.items.create!(name: 'Item1', description: 'Description Here', unit_price: 90)
    item2 = @merchant.items.create!(name: 'Item2', description: 'Description Here', unit_price: 90)
    item3 = @merchant.items.create!(name: 'Item3', description: 'Description Here', unit_price: 90)

    # visit '/merchants/1/items'
    # visit merchant_items_path(merchant.id)
    visit "/merchants/#{@merchant.id}/items"

    expect(page).to have_content(item1.name)
  end
end