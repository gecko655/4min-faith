require_relative '../src/anime-facedetect'
require_relative '../src/4min-faith-util'
require 'test/unit'

class FaceDetectTest < Test::Unit::TestCase

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
    path = FourMinute.new.fetch_gacha_image(/(イベント開催)/)
    assert(facedetect(path))
  end
end