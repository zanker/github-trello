#!/usr/bin/env ruby
$LOAD_PATH.unshift ::File.expand_path(::File.dirname(__FILE__) + "/lib")
require "trello/server"

use Rack::ShowExceptions
run TrelloService::Server.new