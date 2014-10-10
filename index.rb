require 'sinatra'
require 'twilio-ruby'

get '/sms' do
  response = Twilio::TwiML::Response.new do |r|
    r.Message do |m|
      m.Body "Hi Cenk! How are you this morning?"
      m.Media 'http://1.bp.blogspot.com/-vpE6uMJ37dk/UOScrne47aI/AAAAAAAAEL4/Ki-4IWO-SoY/s1600/ron-paul.gif'
    end
  end
  content_type 'text/xml'
  response.text
end

get '/token' do
  capability = Twilio::Util::Capability.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  capability.allow_client_outgoing 'APxxxxxx'
  capability.generate
end

get '/random' do
  client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  nums = client.messages.list(to: 'xxx').collect{|m| m.from}
  random = nums.sample
  response = Twilio::TwiML::Response.new do |r|
    r.Dial callerId: 'xxx' do |d|
      d.Number random
    end
  end
  content_type 'text/xml'
  response.text
end
