class Transaction < ApplicationRecord
  enum status: [:success, :failed] #{0 => success, 1 => failed} What if we want to switch values? Array vs hash movablility???
  belongs_to :invoice
end
