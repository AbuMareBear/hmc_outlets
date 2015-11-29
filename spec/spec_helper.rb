$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'coveralls'
Coveralls.wear!

require 'hmc_outlets'
require 'webmock/rspec'

RSpec.configure do |config|
config.before(:each) do
    stub_request(:get, "http://www.halalhmc.org/certified-outlets-results.htm").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => open(File.dirname(__FILE__) + '/response_body.html'), :headers => {})
  end
end