# vi: set ft=ruby : encoding: utf-8

ROOT, PORT = '/vagrant', 8080

Vagrant.configure(2) do |config|
  config.vm.box = 'pivotus/ror'
  config.vm.box_url = 'ror.box' if File.exists? 'ror.box'
  config.vm.box_check_update = false
  config.vm.network 'forwarded_port', guest: 80, host: PORT
  config.ssh.forward_agent = true

  # Use default shared folder method
  config.vm.synced_folder '.', ROOT,
                          group: 'www-data',
                          mount_options: %w(dmode=775 fmode=775)

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
    APP_ROOT='#{ROOT}' APP_PORT=#{PORT} ror-provision
  "

  config.vm.provision 'shell', run: 'always', inline: "
    APP_ROOT='#{ROOT}' APP_PORT=#{PORT} ror-boot
  "

  config.vm.post_up_message = '
    Uygulama http://localhost:8080 adresinde etkin
  '
end
