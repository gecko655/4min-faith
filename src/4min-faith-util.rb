#! /usr/bin/env ruby
require 'nokogiri'
require 'net/http'
require 'uri'
require 'twitter'
require 'tempfile'
require 'time'
require 'date'

class FourMinute

  def minor_version()
    warn 'deprecated'
    time = Time::now
    end_day_of_month = Date::new(Date::today.year, Date::today.month,-1).day
    time.localtime("+09:00")
    month = time.month
    day = time.day
    moffset = (month-9)*4+9
    hour = time.hour
    return (moffset+0).to_s if day<5 || day==5 && hour<15 #no event
    return (moffset+1).to_s if day<15 || day==15 && hour<15 #event
    return (moffset+2).to_s if day<20 || day==20 && hour<15 #no event
    return (moffset+3).to_s if day<end_day_of_month || day==end_day_of_month && hour<15 #event
    return (moffset+4).to_s if day==end_day_of_month
  end
  def get_response(location)
    uri = URI.parse('http://prod-jp.lovelive.ge.klabgames.net/'+location)
    req = Net::HTTP::Get.new uri
    header = {
      'Authorize' => 'consumerKey=lovelive_test&token='+ENV['ll_token']+'&version=1.1&timeStamp='+Time::now.to_i.to_s+'&nonce=WV0',
      'User-ID' => ENV['ll_User_ID']
    }
    req.initialize_http_header header
    Net::HTTP.new(uri.host, uri.port).start do |http|
      http.request req
    end
  end


  def fetch_gacha_image(regex)
    resp = get_response('webview.php/announce/index')
    page = Nokogiri::HTML(resp.body)
    imgurl = page.css('.ml40').select{|mes| mes.text.match regex}[0]
                 .parent.next_element.css('img')[0]['src']
    image_string = Net::HTTP::get(URI('http:'+imgurl))
    Tempfile.open('tmp.png') do |fo|
      fo.write image_string
      fo.path
    end
  end

  def get_client()
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['consumer_key']
      config.consumer_secret     = ENV['consumer_secret']
      config.access_token        = ENV['access_token']
      config.access_token_secret = ENV['access_token_secret']
    end
  end
  def self.update_with_message(mes, query=/([^「]限定勧誘|新部員)/)
    f = FourMinute.new
    client = f.get_client()
    image = File.open f.fetch_gacha_image(query)
    client.update_with_media mes, image
  end

end

