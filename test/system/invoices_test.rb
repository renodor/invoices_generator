# frozen_string_literal:true

require 'application_system_test_case'

class InvoicesTest < ApplicationSystemTestCase
  setup do
    @invoice = invoices(:first) # Reference to the first fixture invoicee
  end

  test 'Creating a new invoice' do
    # When we visit the Invoice#index page
    # we expect to see a title with the text 'Invoice'
    visit invoices_path
    assert_selector 'h1', text: 'Invoices'

    # When we click on the link with the text 'New invoice'
    # we expect to land on a page with the title 'New invoice'
    click_on 'New invoice'
    assert_selector 'h1', text: 'New invoice'

    # When we fill in the name input with 'Capybara invoice'
    # and we click on 'Create Invoice'
    fill_in 'Name', with: 'Capybara invoice'
    click_on 'Create invoice'

    # We expect to be back on the page with the title 'Invoice'
    # and to see our 'Capybara invoice' added to the list
    assert_selector 'h1', text: 'Invoice'
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
    assert_selector 'h1', text: 'Edit invoice'

    fill_in 'Name', with: 'Updated invoice'
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
