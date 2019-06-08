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

    @gateway ||= Braintree::Gateway.new(
      :environment => :sandbox,
      :merchant_id => 'yqvkxjhrk3f9466z',
      :public_key => 'rd8vrswk49k8w6hf',
      :private_key => 'b457e8ec5b5ddda20b7f7e5977bcaf96',
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