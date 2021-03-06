require File.dirname(__FILE__) + '/spec_helper'

describe 'Client' do
  before(:all) do
    @client = Zank::Client.new(ZANK_USERNAME, ZANK_PASSWORD)
    @login = @client.login
  end

  context 'Login' do
    it 'login successed' do
      expect(@login).to eq true
    end

    it 'login successed, client status should be 1' do
      expect(@client.status).to eq 1
    end

    it 'login failed' do
      client = Zank::Client.new('1', '2')
      expect(client.login).to eq false
    end
  end

  context 'Circles' do 
    it 'should be Circle Array' do
      circles = @client.circles
      expect(circles.class).to eq Array
    end
  end

  context 'Posts' do 
    it 'should be Posts Array without timestamp' do
      posts = @client.posts(circle_id: 135)
      expect(posts.class).to eq Array
    end
    it 'should be Posts Array with timestamp' do
      posts = @client.posts(circle_id: 135, timestamp: (Time.now.to_f * 1000).to_i)
      expect(posts.class).to eq Array
    end
  end

  context 'User' do 
    it 'should be user detail' do
      user = @client.user_detail(@client.user.id)
      expect(user.id).to eq @client.user.id
    end
  end

  context 'Logout' do
    it 'logout successed' do
      client = Zank::Client.new(ZANK_USERNAME, ZANK_PASSWORD)
      client.login
      expect(client.logout).to eq true
    end

    it 'logout successed, client status should be 0' do
      client = Zank::Client.new(ZANK_USERNAME, ZANK_PASSWORD)
      client.login
      client.logout
      expect(client.status).to eq 0
    end
  end
end
