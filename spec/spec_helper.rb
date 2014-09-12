require 'rspec'
require 'rspec/its'
require 'webmock/rspec'
require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start

WebMock.disable_net_connect!(allow: 'codeclimate.com')

require File.expand_path('../../lib/rundeck', __FILE__)

def load_fixture(name)
  prefix = File.dirname(__FILE__) + '/fixtures'

  if File.exist?("#{prefix}/#{name}.xml")
    File.new("#{prefix}/#{name}.xml")

  elsif File.exist?("#{prefix}/#{name}.json")
    File.new("#{prefix}/#{name}.json")

  else
    fail 'Fixture not found'
  end
end

RSpec.configure do |config|
  config.before(:each) do
    Rundeck.endpoint = 'https://api.example.com'
    Rundeck.api_token = 'secret'
  end
end

# GET
def stub_get(path, fixture)
  stub_request(:get, "#{Rundeck.endpoint}#{path}")
      .with(headers: { 'Accept' => 'application/json',
                       'X-Rundeck-Auth-Token' => Rundeck.api_token })
      .to_return(body: load_fixture(fixture))
end

def a_get(path)
  a_request(:get, "#{Rundeck.endpoint}#{path}")
      .with(headers: { 'Accept' => 'application/json',
                       'X-Rundeck-Auth-Token' => Rundeck.api_token })
end

# POST
def stub_post(path, fixture, status_code = 200)
  stub_request(:post, "#{Rundeck.endpoint}#{path}")
      .with(headers: { 'Accept' => 'application/json',
                       'X-Rundeck-Auth-Token' => Rundeck.api_token })
      .to_return(body: load_fixture(fixture), status: status_code)
end

def a_post(path)
  a_request(:post, "#{Rundeck.endpoint}#{path}")
      .with(headers: { 'Accept' => 'application/json',
                       'X-Rundeck-Auth-Token' => Rundeck.api_token })
end

# PUT
def stub_put(path, fixture)
  stub_request(:put, "#{Rundeck.endpoint}#{path}")
      .with(headers: { 'Accept' => 'application/json',
                       'X-Rundeck-Auth-Token' => Rundeck.api_token })
      .to_return(body: load_fixture(fixture))
end

def a_put(path)
  a_request(:put, "#{Rundeck.endpoint}#{path}")
      .with(headers: { 'Accept' => 'application/json',
                       'X-Rundeck-Auth-Token' => Rundeck.api_token })
end

# DELETE
def stub_delete(path, fixture)
  stub_request(:delete, "#{Rundeck.endpoint}#{path}")
      .with(headers: { 'Accept' => 'application/json',
                       'X-Rundeck-Auth-Token' => Rundeck.api_token })
      .to_return(body: load_fixture(fixture))
end

def a_delete(path)
  a_request(:delete, "#{Rundeck.endpoint}#{path}")
      .with(headers: { 'Accept' => 'application/json',
                       'X-Rundeck-Auth-Token' => Rundeck.api_token })
end
