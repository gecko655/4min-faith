#! /usr/bin/env ruby
# 時間設定はDockerfileで
require_relative '4min-faith-util.rb'
image = FourMinute::update_with_message "イベント開始です", /(イベント開催)/
FourMinute::update_profile_image image
