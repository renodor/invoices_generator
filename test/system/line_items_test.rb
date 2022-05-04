# frozen_string_literal:true

require 'application_system_test_case'

class LineItemSystemTest < ApplicationSystemTestCase
  include ActionView::Helpers::NumberHelper

  setup do
    login_as users(:accountant)

    @invoice        = invoices(:first)
    @line_item_date = line_item_dates(:today)
    @line_item      = line_items(:room_today)

    visit invoice_path(@invoice)
  end

  test 'Creating a new line item' do
    assert_selector 'h1', text: 'First invoice'

    within "##{dom_id(@line_item_date)}" do
      click_on 'Add item', match: :first
    end
    assert_selector 'h1', text: 'First invoice'

    fill_in 'Name', with: 'Animation'
    fill_in 'Quantity', with: 1
    fill_in 'Unit price', with: 1234
    click_on 'Create item'

    assert_selector 'h1', text: 'First invoice'
    assert_text 'Animation'
    assert_text number_to_currency(1234)
  end

  test 'Updating a line item' do
    assert_selector 'h1', text: 'First invoice'

    within "##{dom_id(@line_item)}" do
      click_on 'Edit'
    end
    assert_selector 'h1', text: 'First invoice'

    fill_in 'Name', with: 'Capybara article'
    fill_in 'Unit price', with: 1234
    click_on 'Update item'

    assert_text 'Capybara article'
    assert_text number_to_currency(1234)
  end

  test 'Destroying a line item' do
    within "##{dom_id(@line_item_date)}" do
      assert_text @line_item.name
    end

    within "##{dom_id(@line_item)}" do
      click_on 'Delete'
    end

    within "##{dom_id(@line_item_date)}" do
      assert_no_text @line_item.name
    end
  end
end
