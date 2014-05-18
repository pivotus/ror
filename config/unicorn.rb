# encoding: utf-8

APP_ROOT = File.expand_path('../..', __FILE__)

working_directory APP_ROOT
worker_processes ENV['RAILS_ENV'] == 'development' ? 1 : 4
stderr_path APP_ROOT + '/log/unicorn_stderr.log'
stdout_path APP_ROOT + '/log/unicorn_stdout.log'
user 'www-data', 'www-data'
pid '/run/unicorn.pid'
listen '/tmp/unicorn.sock', backlog: 64
timeout 15
preload_app true

GC.copy_on_write_friendly = true if GC.respond_to? :copy_on_write_friendly=

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  ActiveRecord::Base.connection.disconnect! if defined? ActiveRecord::Base
  Caching.redis.quit if defined? Caching.redis
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing'
    puts 'Wait for master to send QUIT'
  end

  ActiveRecord::Base.establish_connection if defined? ActiveRecord::Base

  Caching.redis.client.reconnect if defined? Caching.redis
end
