require 'rubygems' if RUBY_VERSION < '1.9.0' && Puppet.version < '3'
require 'httpclient' if Puppet.features.httpclient?
require 'base64'

Puppet::Type.type(:marathon_app).provide(:v2, :parent => Puppet::Provider) do

  confine :feature => :httpclient
  mk_resource_methods

  def initialize(*args)

    Puppet.info("Initilazing client for marathon")
    @client = self.class.client
    super(*args)
  end

  def self.client
    client = HTTPClient.new
    # Disable SSL cert verification
    client.ssl_config.verify_mode = (OpenSSL::SSL::VERIFY_NONE)
    return client
  end

  def create
    Puppet.info("Creating marathon application")

    extheader = {}
    extheader['accept'] = "application/json"
    extheader['Content-Type'] = "application/json; charset=utf-8"
    url = "#{@resource[:endpoint]}/v2/apps"

    erb_file = "#{Pathname.new(File.expand_path('../../../templates', __FILE__))}/app.json.erb"
    app_json = ERB.new(File.new(erb_file).read, nil, '-').result(binding)
    begin

      response = @client.request(
          'POST',
          url,
          nil,
          app_json,
          extheader
      )

      #TODO: raise error checking
      if response.ok?
        Puppet.info("Created new app called #{name}")
      end
    rescue
      puts response
    end
  end

  def exists?
    Puppet.info("Checking if #{@resource[:name]} exists")
    @property_hash[:ensure] == :present
  end

  def destroy
    @property_hash[:ensure] = :absent
  end
end