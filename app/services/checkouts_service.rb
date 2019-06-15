class CheckoutsService
	TRANSACTION_SUCCESS_STATUSES = [
    Braintree::Transaction::Status::Authorizing,
    Braintree::Transaction::Status::Authorized,
    Braintree::Transaction::Status::Settled,
    Braintree::Transaction::Status::SettlementConfirmed,
    Braintree::Transaction::Status::SettlementPending,
    Braintree::Transaction::Status::Settling,
    Braintree::Transaction::Status::SubmittedForSettlement,
  ]
	def self.gateway
    env = ENV["BT_ENVIRONMENT"]

   gateway = Braintree::Gateway.new(
    :environment => :sandbox,
    :merchant_id => '54br95yxrx789ppw',
    :public_key => 'fgx6z6f6qqrtxh24',
    :private_key => '56f29786c714fb9753db5d1bbd372cd1',
  )
  end

  def self._create_result_hash(transaction)
    status = transaction.status

    if TRANSACTION_SUCCESS_STATUSES.include? status
      result_hash = {
        :header => "Sweet Success!",
        :icon => "success",
        :message => "Your transaction has been successfully processed. Have a nice day!"
      }
    else
      result_hash = {
        :header => "Transaction Failed",
        :icon => "fail",
        :message => "Your test transaction has a status of #{status}."
      }
    end
  end

  def self.transaction_sale(amount,nonce)
		gateway.transaction.sale(
    amount: amount,
    payment_method_nonce: nonce,
    :options => {
      :submit_for_settlement => true
    }
  )
  end	
end