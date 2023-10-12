#!/usr/bin/ruby

require 'microsoft_teams_incoming_webhook_ruby'
require 'colorize'
require 'optparse'
require 'yaml'
require 'erb'

$stdout.sync = true 
$stdin.sync = true

# config-file where to find the web-URL (secret)
class Account
  def self.configuration
    YAML.safe_load(ERB.new(File.read('msteams_connector.yaml')).result)
  end
end

class Createconfig
  def self.sceleton
    if File.exists?('msteams_connector.yaml')
      puts "ERROR: configfile already exists.".red
      exit 1
    else
      File.open("msteams_connector.yaml", "a") do |line|
        line.puts "channelname:"
        line.puts "  name: \"an optional name or description\""
        line.puts "  secret_uri: \"the secret channel-URI from the incoming-webhook\""
      end
    end
  end
end

myname = File.basename(__FILE__)
options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: #{myname} [options]"

  options[:newconfig] = nil
  opts.on('-n','--newconfig','Write new config file template') do |w|
    options[:newconfig] = true
  end

  options[:list] = nil
  opts.on('-l','--list','list configured channels.') do
    options[:list] = true
  end

  options[:channel] = nil
  opts.on('-c','--channel c','Channel where to post to.') do |n|
    options[:channel] = n
  end

  options[:message] = nil
  opts.on('-m ', '--message m', 'Message text.') do |x|
    options[:message] = x
  end
end
optparse.parse!


if options[:newconfig] == true
  Createconfig.sceleton
  puts "done.".green
  exit 0
end

if options[:list] == true
  puts "Channel-list:"
  config_options = YAML.load_file("msteams_connector.yaml")
  config_options.each do |key, value|
    puts " -> #{key}"
  end
  exit 0
end

if options[:message].nil?
  puts "ERROR: What messagetext should i send?".cyan
  puts ""
  puts optparse
  exit 2
end

if options[:channel].nil?
  puts "ERROR: need a target channel.".cyan
  puts ""
  puts optparse
  exit 2
else
  chat = options[:channel]
  puts "Posting goes to: #{chat}"
end



uri = Account.configuration[chat]['secret_uri']
puts "Fireing up, this may take a few seconds ..."
message = MicrosoftTeamsIncomingWebhookRuby::Message.new do |m|
    m.url = uri
    m.text = options[:message].to_s
  end
  
message.send
