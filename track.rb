require "octokit"

# Provide authentication credentials
client = Octokit::Client.new(:access_token => ENV['TOKEN'])

client.auto_paginate = true
source = ENV['REPO']

peeps = client.stargazers(source)

# Get package here: https://github.com/iron-io/iron_mq_ruby
require 'iron_mq'

@ironmq = IronMQ::Client.new

@queue = @ironmq.queue("peeps")

peeps.each do |peep|
  @queue.post(peep.login)
end
