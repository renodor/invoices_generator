# frozen_string_literal:true

class Company < ApplicationRecord
  has_many :users
  has_many :invoices

  validates :name, presence: true
end
