# frozen_string_literal:true

class LineItemDate < ApplicationRecord
  belongs_to :invoice

  validates :date, presence: true, uniqueness: { scope: :invoice_id }

  scope :ordered, -> { order(date: :asc) }

  def previous_date
    invoice.line_item_dates.ordered.where('date < ?', date).last
  end
end
