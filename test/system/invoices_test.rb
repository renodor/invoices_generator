# frozen_string_literal:true

require 'application_system_test_case'

class InvoicesTest < ApplicationSystemTestCase
  test 'Creating a new invoice' do
    # When we visit the Invoice#index page
    # we expect to see a title with the text 'Invoice'
    visit invoice_path
    assert_selector 'h1', text: 'Invoice'

    # When we click on the link with the text 'New quote'
    # we expect to land on a page with the title 'New quote'
    click_on 'New quote'
    assert_selector 'h1', text: 'New quote'

    # When we fill in the name input with 'Capybara quote'
    # and we click on 'Create Quote'
    fill_in 'Name', with: 'Capybara quote'
    click_on 'Create quote'

    # We expect to be back on the page with the title 'Invoice'
    # and to see our 'Capybara quote' added to the list
    assert_selector 'h1', text: 'Invoice'
    assert_text 'Capybara quote'
  end
end
