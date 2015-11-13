require 'ropencv'
include OpenCV

def facedetect(image_path)
  return unless image_path.kind_of? String
  #depends on openCV installation so copied into the directory for easier access
  face_cascade_name = "./cascade/lbpcascade_animeface.xml"

  frame_gray =  cv::Mat.new
  face_cascade = cv::CascadeClassifier.new
  puts face_cascade.load(face_cascade_name) ? ' loaded' : 'not loaded'

  frame = cv::imread(image_path)
  faces = Std::Vector.new(cv::Rect)

  cv::cvt_color(frame,frame_gray, cv::COLOR_BGR2GRAY)
  cv::equalizeHist( frame_gray, frame_gray )

  face_cascade.detect_multi_scale( frame_gray, faces, 1.1, 2, )
  puts faces.size
  faces.each_with_index do |face, i|
    next if face.height<50||face.height>200||face.width<50||face.width>200
    face_image = frame.block(face)
    cv::imwrite("/tmp/test_"+i.to_s+".jpg",face_image)
  end
end

