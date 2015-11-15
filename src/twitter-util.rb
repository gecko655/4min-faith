class TwitterUtil
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
    @client.update_with_media mes, image
  end
  def update_profile_image(image)
    @client.update_profile_image(image)
  end


end
