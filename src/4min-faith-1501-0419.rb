#! /usr/bin/env ruby
# 時間設定はDockerfileで
require_relative '4min-faith-util.rb'
FourMinute::update_with_message "次回のイベント情報", /(イベント開催)/