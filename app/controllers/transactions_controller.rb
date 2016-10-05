class TransactionsController < ApplicationController
  def show
    token = Braintree::ClientToken.generate
    render json: {token: token}
  end

  def create
    result = Braintree::Transaction.sale(
      amount: params[:amount],
      payment_method_nonce: params[:nonce],
      options: {
        submit_for_settlement: false
      }
    )
    render json: {
      status: result.transaction.status
    }
  end
end
