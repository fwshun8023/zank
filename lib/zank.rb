require 'digest/md5'
require 'uuid'
require 'json'
require 'zank/version'
require 'zank/client'
require 'zank/user'
require 'faraday'

module Zank
  BASE_URL    = "http://apiproxy.zank.mobi"
  LOGIN_PATH  = "/snowball/api/account/account/login.json"
  LOGOUT_PATH = "/snowball/api/account/account/logout.json"
end