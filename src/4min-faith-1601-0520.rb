#! /usr/bin/env ruby
# 時間設定はDockerfileで
require_relative '4min-faith-util.rb'
image_path = FourMinute::get_gacha_image /(イベント開催)/
FourMinute::update_profile_image image_path
FourMinute::update_with_message image_path, "イベント開始です"
