require 'opencv'
include OpenCV

def facedetect(path)
  return false unless path.kind_of? String
  data = './cascade/lbpcascade_animeface.xml'
  detector = CvHaarClassifierCascade::load(data)
  image = CvMat.load(path)
  regions = detector.detect_objects(image)
  print regions.length()
  return false if regions.empty?
  face = image.subrect(regions.first)
  face.save_image("/tmp/test.jpg")
  return true
end
