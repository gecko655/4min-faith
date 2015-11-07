require 'opencv'
include OpenCV

def facedetect(path)
  return false unless path.kind_of? String
  data = './cascade/haarcascade_frontalface_alt.xml'
  detector = CvHaarClassifierCascade::load(data)
  image = CvMat.load(path)
  regions = detector.detect_objects(image)
  print regions.length()
  return false if regions.empty?
  face = image.subrect(region.first)
  face.save_image("/tmp/test.jpg")
  return true
end
