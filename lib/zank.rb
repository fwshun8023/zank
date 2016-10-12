require 'digest/md5'
require 'uuid'
require 'json'
require 'zank/version'
require 'zank/client'
require 'zank/user'
require 'faraday'

module Zank
  BASE_URL    = 'http://apiproxy.zank.mobi'.freeze
  LOGIN_PATH  = '/snowball/api/account/account/login.json'.freeze
  LOGOUT_PATH = '/snowball/api/account/account/logout.json'.freeze
end
