module Fixture
  URL = 'https://api.snap-ci.com/project/'

  def load_json_fixture(name)
    load_fixture(name + '.json')
  end

  def load_message_fixture(name)
    load_fixture(name + '.message')
  end

  def load_fixture(name)
    File.read(File.expand_path("spec/fixtures/#{name}"))
  end

  def stub_snap_requests
    # Api example
    stub_request(:get, "#{URL}oneorg/api/branch/development/pipelines").
      to_return(status: 200, body: load_json_fixture('api_development'))
    stub_request(:get, "#{URL}oneorg/api/branch/staging/pipelines").
      to_return(status: 200, body: load_json_fixture('api_staging'))
    stub_request(:get, "#{URL}oneorg/api/branch/master/pipelines").
      to_return(status: 200, body: load_json_fixture('api_master'))

    # Front example
    stub_request(:get, "#{URL}oneorg/front/branch/staging/pipelines").
      to_return(status: 200, body: load_json_fixture('front_staging'))
    stub_request(:get, "#{URL}oneorg/front/branch/master/pipelines").
      to_return(status: 200, body: load_json_fixture('front_master'))

    # Websites example
    stub_request(:get, "#{URL}otherorg/websites/branch/develop/pipelines").
      to_return(status: 200, body: load_json_fixture('websites_develop'))
    stub_request(:get, "#{URL}otherorg/websites/branch/master/pipelines").
      to_return(status: 200, body: load_json_fixture('websites_master'))
    # wrong_project example
    stub_request(:get, "#{URL}wrong_org/wrong_project/branch/wrong_branch/pipelines").
      to_return(status: 404, body: load_json_fixture('error'))
  end
end
