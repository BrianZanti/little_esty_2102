require 'rails_helper'

RSpec.describe Customer, type: :model do
  it {should have_many :invoices}

  describe 'instance methods' do
    describe 'top_merchants' do

      before :each do
        @customer = Customer.create!(first_name: 'Brian', last_name: 'Zanti')

        @merchant_1 = Merchant.create!(name: 'Merchant 1')
        @merchant_2 = Merchant.create!(name: 'Merchant 2')
        @merchant_3 = Merchant.create!(name: 'Merchant 3')
        @merchant_4 = Merchant.create!(name: 'Merchant 4')
        @merchant_5 = Merchant.create!(name: 'Merchant 5')
        @merchant_6 = Merchant.create!(name: 'Merchant 6')
        @merchant_7 = Merchant.create!(name: 'Merchant 7')

        # Lots of revenue but no successful transactions
        item_1a = @merchant_1.items.create!

        item_2a = @merchant_2.items.create!
        item_2b = @merchant_2.items.create!

        item_3a = @merchant_3.items.create!
        item_3b = @merchant_3.items.create!

        item_4a = @merchant_4.items.create!
        item_4b = @merchant_4.items.create!

        item_5a = @merchant_5.items.create!
        item_5b = @merchant_5.items.create!

        item_6a = @merchant_6.items.create!
        item_6b = @merchant_6.items.create!

        item_7 = @merchant_7.items.create!

        invalid_invoice = @customer.invoices.create!
        invalid_invoice.invoice_items.create!(item: item_1a, quantity: 10, unit_price: 1_000_000)

        # 20 dollars in revenue for merchant 2
        invoice_2 = @customer.invoices.create!
        invoice_2.transactions.create!(result: :success)
        invoice_2.invoice_items.create!(item: item_2a, quantity: 1, unit_price: 10)
        invoice_2.invoice_items.create!(item: item_2b, quantity: 10, unit_price: 1)


        # 110 dollars in revenue for merchant 3
        invoice_3a = @customer.invoices.create!
        invoice_3b = @customer.invoices.create!
        invoice_3a.transactions.create!(result: :success)
        invoice_3b.transactions.create!(result: :success)
        invoice_3a.invoice_items.create!(item: item_3a, quantity: 10, unit_price: 10)
        invoice_3b.invoice_items.create!(item: item_3b, quantity: 10, unit_price: 1)

        # 2 dollars in revenue for merchant 4
        invoice_4a = @customer.invoices.create!
        invoice_4b = @customer.invoices.create!
        invoice_4a.transactions.create!(result: :success)
        invoice_4b.transactions.create!(result: :success)
        invoice_4a.invoice_items.create!(item: item_4a, quantity: 1, unit_price: 1)
        invoice_4b.invoice_items.create!(item: item_4b, quantity: 1, unit_price: 1)

        # 10 dollars in revenue for merchant 5
        invoice_5a = @customer.invoices.create!
        invoice_5b = @customer.invoices.create!
        invoice_5a.transactions.create!(result: :success)
        invoice_5b.transactions.create!(result: :success)
        invoice_5a.invoice_items.create!(item: item_5a, quantity: 5, unit_price: 1)
        invoice_5b.invoice_items.create!(item: item_5b, quantity: 1, unit_price: 5)

        # 12 dollars in revenue for merchant 6
        invoice_6a = @customer.invoices.create!
        invoice_6b = @customer.invoices.create!
        invoice_6a.transactions.create!(result: :success)
        invoice_6b.transactions.create!(result: :success)
        invoice_6a.invoice_items.create!(item: item_6a, quantity: 6, unit_price: 1)
        invoice_6b.invoice_items.create!(item: item_6b, quantity: 2, unit_price: 3)

        # 60 dollars for merchant 7
        invoice_6b.invoice_items.create!(item: item_7, quantity: 20, unit_price: 3)

        # no successful transactions
        invoice_6c = @customer.invoice.create!
        invoice_6c.invoice_items.create!(item: item_6a, quantity: 1, unit_price: 1_000_000)
      end

      it 'returns the top 5' do
        expect(@customer.top_merchant).to eq([@merchant_3, @merchant_7, @merchant_2, @merchant_6, @merchant_5])
      end

      it 'only includes successful transactions'

      it 'calculates invoice item price times quantity'
      it 'does not include other customer information'

      it 'only returns top 3 if I only have transactions with 3 merchants'
    end
  end
end
