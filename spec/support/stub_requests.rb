module StubRequests
  def self.included(base)
    base.before { stub_requests! }
  end

  def stub_requests!
    stub_wsdl!
  end

  def stub_wsdl!
    stub_request(:get, PayuZa.wsdl_endpoint)
      .to_return(body: fixture(:staging_wsdl))
  end
end
