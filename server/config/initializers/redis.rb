# Server::Redis = Redis.new(host: redis_host, port: redis_port.to_i)

REDIS_CONFIG = YAML.load( File.open( Rails.root.join("config/redis.yml") ) ).symbolize_keys
config = REDIS_CONFIG[:default].symbolize_keys
config = config.merge(REDIS_CONFIG[Rails.env.to_sym].symbolize_keys) if REDIS_CONFIG[Rails.env.to_sym]

Server::Redis = Redis.new(config)

# To clear out the db before each test
Server::Redis.flushdb if Rails.env == "test"