require_relative '4min-faith-util'
image_path = FourMinute::get_gacha_image /([^「]限定勧誘|新部員)/
# image_path = FourMinute::get_gacha_image /(イベント開催)/
FourMinute.update_profile_image image_path
