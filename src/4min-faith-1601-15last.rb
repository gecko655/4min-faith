#! /usr/bin/env ruby
# 時間設定はDockerfileで
require_relative '4min-faith-util.rb'
image = FourMinute::update_with_message "本日追加の新部員情報"
FourMinute::update_profile_image image
