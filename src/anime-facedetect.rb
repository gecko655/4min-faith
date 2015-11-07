require 'opencv'

def facedetect(path)
  return false unless path.kind_of? String
  data = './cascade/haarcascade_frontalface_alt.xml'
  detector = CvHaarClassifierCascade::load(data)
  image = CvMat.load(path)
  region = detector.detect_objects(image).first
  return false if region==nil
  face = image.subrect(region)
  face.save_image("/tmp/test.jpg")
  return true
end
