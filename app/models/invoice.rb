# frozen_string_literal:true

class Invoice < ApplicationRecord
  belongs_to :company
  has_many :line_item_dates, dependent: :destroy
  has_many :line_items, through: :line_item_dates

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  # after_create_commit -> { broadcast_prepend_later_to 'invoices', partial: 'invoices/invoice', locals: { invoice: self }, target: 'invoices' }
  # previous line can be shortened to after_create_commit -> { broadcast_prepend_to 'invoices' }

  # after_update_commit -> { broadcast_replace_later_to 'invoices' }
  # after_destroy_commit -> { broadcast_remove_to 'invoices' }

  # And all Those three previous callbacks are equivalent to the following single line
  # broadcasts_to ->(invoice) { "invoice" }, inserts_by: :prepend

  # And previous callback needs to be scoped to company to avoid streaming invoices to users from other companies
  broadcasts_to ->(invoice) { [invoice.company, 'invoices'] }, inserts_by: :prepend

  def total_price
    line_items.sum(&:total_price)
  end
end
