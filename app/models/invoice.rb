# frozen_string_literal:true

class Invoice < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  after_create_commit -> { broadcast_prepend_later_to 'invoices', partial: 'invoices/invoice', locals: { invoice: self }, target: 'invoices' }
  # can be shortened to after_create_commit -> { broadcast_prepend_to 'invoices' }

  after_update_commit -> { broadcast_replace_later_to 'invoices' }
  after_destroy_commit -> { broadcast_remove_to 'invoices' }

  # Those three previous callbacks are equivalent to the following single line
  # broadcasts_to ->(invoice) { "invoice" }, inserts_by: :prepend
end
