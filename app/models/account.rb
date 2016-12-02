class Account < ActiveRecord::Base
  belongs_to :client
  has_many :transactions

  validates :name, presence: true


def create_transaction(type,amount)
  self.transactions.create(description: type, amount: amount)
end



end
