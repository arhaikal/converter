class Exchange < ApplicationRecord
  belongs_to :user
  validates_presence_of :target_currency,
                        :base_currency
  validates :amount, inclusion: { in: 1..100000000,
                                  message: "The amount can be between 1 and 100000000" },

  validates :waiting_time, inclusion: { in: 1..250,
                                        message: "The amount must be between 1 and 250" }


end
