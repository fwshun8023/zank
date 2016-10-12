require 'digest/md5'
require 'uuid'
require 'json'
require 'zank/version'
require 'zank/client'
require 'zank/user'
require 'zank/circle'
require 'faraday'

module Zank
  BASE_URL     = 'http://apiproxy.zank.mobi'.freeze
  LOGIN_PATH   = '/snowball/api/account/account/login.json'.freeze
  LOGOUT_PATH  = '/snowball/api/account/account/logout.json'.freeze
  CIRCLES_PATH = '/snowball/api/circle/circle/queryMyCircle.json'.freeze
end
