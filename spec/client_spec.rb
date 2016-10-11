require File.dirname(__FILE__) + '/spec_helper'

describe 'Client' do
  before(:all) do
    @client = Zank::Client.new(ZANK_USERNAME, ZANK_PASSWORD)
  end

  context "Login" do
    it "login successed" do
      @client.login
      expect(@client.status).to eq 1
    end

    it "login failed" do
      client = Zank::Client.new("x", "x")
      client.login
      expect(client.status).to eq 0
    end
  end


end