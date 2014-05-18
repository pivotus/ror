require 'redis'

module Caching
  def self.redis
    @redis ||= Redis.new path: ENV['REDIS_SOCK'] || '/tmp/redis.sock'
  end
end
