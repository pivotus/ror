# vi: set ft=ruby : encoding: utf-8

Vagrant.configure(2) do |config|
  config.vm.box = 'pivotus/ror'
  config.vm.box_url = 'ror.box' if File.exists? 'ror.box'
  config.vm.box_check_update = false
  config.vm.network 'forwarded_port', guest: 80, host: 8080
  config.ssh.forward_agent = true

  # Use default sync method
  config.vm.synced_folder '.', '/vagrant',
                          group: 'www-data',
                          mount_options: %w(dmode=775 fmode=775)

  # Use rsynced shared folders
  # config.vm.synced_folder '.', '/vagrant',
  #                         type: 'rsync',
  #                         rsync__exclude: %w(
  #                           .git/ *.box *.iso
  #                         ),
  #                         rsync__args: %w(
  #                           --chmod=Dugo+w --verbose --archive --delete -z
  #                         )

  config.vm.provision 'shell', inline: '
    cd /vagrant && bundle install
  '

  config.vm.provision 'shell', run: 'always', inline: '
    echo vagrant | sudo -S service unicorn start
  '

  config.vm.post_up_message = '
    Uygulama http://localhost:8080 adresinde etkin
  '
end
