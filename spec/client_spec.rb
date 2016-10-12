require File.dirname(__FILE__) + '/spec_helper'

describe 'Client' do
  before(:all) do
    @client = Zank::Client.new(ZANK_USERNAME, ZANK_PASSWORD)
  end

  context 'Login' do
    it 'login successed' do
      login = @client.login
      expect(login).to eq true
    end

    it 'login failed' do
      client = Zank::Client.new('1', '2')
      login = client.login
      expect(login).to eq false
    end
  end

  context 'Logout' do
    it 'logout successed' do
      @client.login
      expect(@client.logout).to eq true
    end

    it 'logout failed' do
      expect(@client.logout).to eq false
    end
  end
end
