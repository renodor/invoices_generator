# frozen_string_literal:true

require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test '#total_price returns the sum of the total price of all line items' do
    assert_equal 2500, invoices(:first).total_price
  end
end
