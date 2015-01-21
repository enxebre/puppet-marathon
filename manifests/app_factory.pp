# == Class: rmg_sensu::check_factory
#
# Class responsible for creating a load of checks.
#
#
class marathon::app_factory (
  $apps = {},
) {

  if $apps {
    create_resources('marathon_app', $apps)
  }
}