# frozen_string_literal:true

require 'application_system_test_case'

class InvoicesTest < ApplicationSystemTestCase
  setup do
    login_as users(:accountant)
    @invoice = Invoice.ordered.first
  end

  test 'Creating a new invoice' do
    visit invoices_path
    assert_selector 'h1', text: 'Invoices'

    click_on 'New invoice'
    fill_in 'Name', with: 'Capybara invoice'

    assert_selector 'h1', text: 'Invoices'
    click_on 'Create invoice'

    assert_selector 'h1', text: 'Invoices'
    assert_text 'Capybara invoice'
  end

  test 'Showing a invoice' do
    visit invoices_path
    click_link @invoice.name

    assert_selector 'h1', text: @invoice.name
  end

  test 'Updating a invoice' do
    visit invoices_path
    assert_selector 'h1', text: 'Invoices'

    click_on 'Edit', match: :first
    fill_in 'Name', with: 'Updated invoice'

    assert_selector 'h1', text: 'Invoices'
    click_on 'Update invoice'

    assert_selector 'h1', text: 'Invoices'
    assert_text 'Updated invoice'
  end

  test 'Destroying a invoice' do
    visit invoices_path
    assert_text @invoice.name

    click_on 'Delete', match: :first
    assert_no_text @invoice.name
  end
end
