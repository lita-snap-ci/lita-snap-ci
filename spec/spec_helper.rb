require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "lita-snap-ci"
require "lita/rspec"
require 'webmock/rspec'
WebMock.disable_net_connect!(:allow => "codeclimate.com")

# Load helpers
require_relative 'support/fixture'
require_relative 'support/config'

# A compatibility mode is provided for older plugins upgrading from Lita 3. Since this plugin
# was generated with Lita 4, the compatibility mode should be left disabled.
Lita.version_3_compatibility_mode = false

RSpec.configure do |c|
  c.include Fixture
  c.include Config
  c.before(:each) do
    stub_snap_requests
  end
end
