module StubRequests
  def self.included(base)
    base.before { stub_requests! }
  end

  def stub_requests!
    stub_wsdl!
    stub_endpoints!
  end

  def stub_wsdl!
    stub_request(:get, PayuZa.wsdl_endpoint)
      .to_return(body: fixture(:staging_wsdl, :xml))
  end

  def stub_endpoints!
    stub_request(:post, "https://staging.payu.co.za/service/PayUAPI")
      .with(body: /GetTransaction/)
      .to_return(body: fixture(:get_transaction_response, :xml))

    stub_request(:post, "https://staging.payu.co.za/service/PayUAPI")
      .with(body: /DoTransaction/)
      .to_return(body: fixture(:do_transaction_response, :xml))
  end
end
