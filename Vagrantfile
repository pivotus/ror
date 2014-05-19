# vi: set ft=ruby : encoding: utf-8

ROOT, PORT, ENVIRONMENT = '/vagrant', 8080, 'development'

Vagrant.configure(2) do |config|
  config.vm.box = 'pivotus/ror'
  config.vm.box_url = 'ror.box' if File.exists? 'ror.box'
  config.vm.box_check_update = false
  config.vm.network 'forwarded_port', guest: 80, host: PORT
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
    ror-provision #{ROOT} #{PORT}
  "

  config.vm.provision 'shell', run: 'always', inline: "
    ror-boot #{ENVIRONMENT}
  "

  config.vm.post_up_message = '
    Uygulama http://localhost:8080 adresinde etkin
  '
end
