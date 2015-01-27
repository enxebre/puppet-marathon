require 'puppet/parameter/boolean'
require 'httpclient' if Puppet.features.httpclient?

Puppet::Type.newtype(:marathon_app) do
  @doc = 'type representing a marathon_app'

  ensurable

  #TODO: more strict validation according to marathon api
  newparam(:name, :namevar => true) do
    desc 'the name of the marathon_app'
    validate do |value|
      fail Puppet::Error, 'Should not contains spaces' if value =~ /\s/
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
  end

  newproperty(:id) do
    desc 'the app id'
    validate do |value|
      fail Puppet::Error, 'Should not contains spaces' if value =~ /\s/
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
  end

  newproperty(:endpoint) do
    desc 'the marathon endpoint'
    validate do |value|
      fail Puppet::Error, 'Should not contains spaces' if value =~ /\s/
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
  end

  newproperty(:cpus) do
    desc 'the cpus usage'
    validate do |value|
      fail Puppet::Error, 'Should not contains spaces' if value =~ /\s/
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
  end

  newproperty(:mem) do
    desc 'the mem usage'
    validate do |value|
      fail Puppet::Error, 'Should not contains spaces' if value =~ /\s/
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
  end

  newproperty(:cmd) do
    desc 'the command to use'
    validate do |value|
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
    def insync?(is)
      is.to_i == should.to_i
    end
  end

  newproperty(:port) do
    desc 'the port to use'
    validate do |value|
      fail Puppet::Error, 'Empty values are not allowed' if value == ''
    end
    def insync?(is)
      is.to_i == should.to_i
    end
  end

  newproperty(:instances) do
    desc 'the instances to run on startup'
  end

end
