#! /usr/bin/env ruby
# 時間設定はDockerfileで
require_relative '4min-faith-util.rb'
image_path = FourMinute::get_gacha_image
FourMinute::update_with_message "4分教: 0時4分まであと3分", image_path