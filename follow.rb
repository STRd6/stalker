require "octokit"
require 'iron_mq'

require "./setup"

# Provide authentication credentials
client = Octokit::Client.new(:access_token => ENV['TOKEN'])

@ironmq = IronMQ::Client.new

# Get a Queue object
@queue = @ironmq.queue("peeps")

# Get a message
msg = @queue.get()

person = msg.body

puts "following #{person}"

client.follow(person)

# Delete the message
msg.delete # or @queue.delete(msg.id)
