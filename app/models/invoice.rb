# frozen_string_literal:true

class Invoice < ApplicationRecord
  validates :name, presence: true
end
