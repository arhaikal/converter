class Exchange < ApplicationRecord
  belongs_to :user
  validates_presence_of :amount,
                        :waiting_time,
                        :target_currency,
                        :base_currency
end
