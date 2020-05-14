
# The `consul_lookup` is a hiera 5 `data_hash` data provider function.
# See [the configuration guide documentation](https://puppet.com/docs/puppet/latest/hiera_config_yaml_5.html#configuring-a-hierarchy-level-built-in-backends) for
# how to use this function.
require 'logger'

Puppet::Functions.create_function(:arvo_log) do
  dispatch :arvo_log do
    param 'Variant[String, Numeric]', :key
    param 'Hash', :options
    param 'Puppet::LookupContext', :context
  end


  def arvo_log(key, options, context)
    log_key(key, options)
    context.not_found
    return nil

  end

  def log_key(key, options)
    api = 'http://localhost:8162/v1/keys'
    tag = 'localhost'
    if options.key?('api')
      api = options['api']
    end
    if options.key?('tag')
      tag = options['tag']
    end
    uri = URI(api)
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = {certname: tag, key: key}.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end
  # def lookup_supported_params
  #   [
  #       :logdir,
  #       :size,
  #       :retention,
  #       :tag
  #   ]
  # end

end