class Exchange < ApplicationRecord
  belongs_to :user
  validates_presence_of :target_currency,
                        :base_currency
  validates :amount, {minimum: 1, maximum: 100000000},
                     presence: true,
                     numericality: true
  validates :waiting_time, {minimum: 1, maximum: 250},
                           presence: true,
                           numericality: { only_integer: true }


end
