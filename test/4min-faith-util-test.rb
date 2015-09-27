require 'net/http'
require_relative '../src/4min-faith-util'
require 'test/unit'

class UtilTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_1
    f = FourMinute.new
    resp = f.get_response('webview.php/announce/index')
    assert_not_empty(resp.body,"The response is empty")
    page = Nokogiri::HTML(resp.body)
    imgurl = page.css('.ml40').select{|mes| mes.text.match /([^「]限定勧誘|新部員)/}[0].parent.next_element.css('img')[0]['src']
    puts 'The image url of gacha is: http:' + imgurl
  end
  def test_2
    f = FourMinute.new
    resp = f.get_response('webview.php/announce/index')
    assert_not_empty(resp.body,"The response is empty")
    page = Nokogiri::HTML(resp.body)
    imgurl = page.css('.ml40').select{|mes| mes.text.match /(イベント開催)/}[0].parent.next_element.css('img')[0]['src']
    puts 'The image url of event is: http:' + imgurl
  end
end
