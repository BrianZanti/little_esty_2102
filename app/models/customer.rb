class Customer < ApplicationRecord
  has_many :invoices

  def top_merchant
    invoices.joins(:transactions)
            .joins(:merchants)
            .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
            .limit(5)
            .where(transactions: {result: :success})
            .group('merchants.id')
            .order('revenue desc')

    # Caculations e.g. sum, pluck, average return raw data (strings, integers, hashes)
    # Certain methods will return a single object, find, find_by
    # Most other methods return an AR Relation

    # invoices.joins(:transactions)
    #         .joins(:merchants)
    #         .select('merchants.*')
    #         .limit(5)
    #         .where(transactions: {result: :success})
    #         .order('sum(invoice_items.quantity * invoice_items.unit_price) desc')
    #         .group('merchants.id')
  end
end
