# @api private 
# This class handles the ntp service. Avoid modifying private classes.
class ntp::service inherits ntp {

  if ! ($ntp::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }
  
   # hack for Amazon Linux 2 service proider
  if ($::operatingsystem == 'Amazon' and $::operatingsystemrelease == '2') {
    $service_provider = "systemd"
  } else {
    $service_provider = $ntp::service_provider
  }

  if $ntp::service_manage == true {
    service { 'ntp':
      ensure     => $ntp::service_ensure,
      enable     => $ntp::service_enable,
      name       => $ntp::service_name,
      provider   => $service_provider,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
