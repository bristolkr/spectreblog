require 'erb'
require 'webrick'
require 'yaml'

# File.open 'index.html', 'w' do |file| 
#   file.write template.result
# end

# root = File.expand_path "."

# server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root

# server.mount_proc '/' do |req, res|
#   @post = YAML.load_file('post.yml')
#   template = ERB.new(File.read('index.html.erb'))
#   res.body = template.result
# end

ROOT = File.dirname(__FILE__)

server = WEBrick::HTTPServer.new(:Port => 8000)

server.mount '/assets', WEBrick::HTTPServlet::FileHandler, "#{ROOT}/public"

server.mount_proc '/' do |req, res|
  @post = YAML.load_file('post.yml')
  template = ERB.new(File.read("#{ROOT}/index.html.erb"))
  res.body = template.result
end

trap 'INT' do
  server.shutdown
end

server.start