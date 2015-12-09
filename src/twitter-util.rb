class TwitterUtil
  @tag = ' #スクフェス #ラブライブ #llsif #lovelive '
  @client
  def initialize()
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['consumer_key']
      config.consumer_secret     = ENV['consumer_secret']
      config.access_token        = ENV['access_token']
      config.access_token_secret = ENV['access_token_secret']
    end
  end

  def update_with_media(mes, image)
    @client.update_with_media mes+@tag, image
  end
  def update_profile_image(image)
    for f in 1..3
      begin
        @client.update_profile_image(image)
        break
      rescue Twitter::Error::BadRequest => e
        raise e if f==3
        print e
        print 'update_profile_image failed. try again'
      end
    end
  end


end
