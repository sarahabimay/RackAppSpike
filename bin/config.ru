#!/usr/bin/env ruby
require 'rack'
$LOAD_PATH << File.expand_path("../../lib", __FILE__)
require "request_controller"

Rack::Handler::WEBrick.run(
    RequestController.new,
   :Port => 9000
)
