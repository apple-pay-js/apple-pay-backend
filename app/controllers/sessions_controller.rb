class SessionsController < ApplicationController
  def show
    session = merchant.start_session! params[:validation_url]
    render json: session
  end

  private

  def merchant
    client_cert = OpenSSL::X509::Certificate.new(
      ENV['APPLE_PAY_MERCHANT_IDENTITY_CERT']
    )
    private_key = OpenSSL::PKey::RSA:.new(
      ENV['APPLE_PAY_MERCHANT_IDENTITY_PRIVATE_KEY']
    )

    ApplePay::Merchant.new(
      ENV['APPLE_PAY_MERCHANT_ID'],
      domain: ENV['APPLE_PAY_MERCHANT_DOMAIN'],
      display_name: ENV['APPLE_PAY_MERCHANT_DISPLAY_NAME'],
    ).authenticate(
      client_cert, private_key
    )
  end
end
