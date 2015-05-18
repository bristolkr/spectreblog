require 'erb'
require 'webrick'
require 'yaml'

ROOT = File.dirname(__FILE__)

PORT = ENV["PORT"] || 8000

server = WEBrick::HTTPServer.new(:Port => PORT)

server.mount '/assets', WEBrick::HTTPServlet::FileHandler, "#{ROOT}/public"

server.mount_proc '/' do |req, res|
  @post = YAML.load_file('post.yml')
  template = ERB.new(File.read("#{ROOT}/public/index.html.erb"))
  res.body = template.result
end

trap 'INT' do
  server.shutdown
end

server.start