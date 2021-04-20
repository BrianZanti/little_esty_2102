class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :unicorns
end
