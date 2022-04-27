# frozen_string_literal:true

class Invoice < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }
end
