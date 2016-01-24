# Configure nodejs environment for system
class nodejsenv(
  $versions = [],
  $default,
) {
  $modules = hiera_array('nodejsenv::modules', [])

  include nodejs

  nodejs::version { $versions: }

  class { 'nodejs::global':
    version => $default
  }

  $modules.each |$module| {
    npm_module { "${module} for all nodes":
      module       => $module,
      node_version => '*'
    }
  }
}
