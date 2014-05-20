# vi: set ft=ruby : encoding: utf-8

ROOT, HTTP, HTTPS, ENVIRONMENT =
  '/vagrant', 8080, 8443, 'development'

Vagrant.configure(2) do |config|
  config.vm.box = 'pivotus/ror'
  config.vm.box_url = 'ror.box' if File.exists? 'ror.box'
  config.vm.box_check_update = false
  config.vm.network 'forwarded_port', guest: 80, host: HTTP
  config.vm.network 'forwarded_port', guest: 443, host: HTTPS
  config.ssh.forward_agent = true

  # Use default shared folder method
  config.vm.synced_folder '.', ROOT,
                          group: 'www-data',
                          mount_options: %w(dmode=775 fmode=664)

  # Use rsynced shared folders
  # config.vm.synced_folder '.', ROOT,
  #                         type: 'rsync',
  #                         rsync__exclude: %w(
  #                           .git/ *.box *.iso
  #                         ),
  #                         rsync__args: %w(
  #                           --chmod=Dugo+w --verbose --archive --delete -z
  #                         )

  config.vm.provision 'shell', inline: "
    export APP_ROOT=#{ROOT} APP_HTTP=#{HTTP} APP_HTTPS=#{HTTPS}
    ror-provision
  "

  config.vm.provision 'shell', run: 'always', inline: "
    ror-boot #{ENVIRONMENT}
  "
end
