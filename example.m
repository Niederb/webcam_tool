% Processing a single image
img = imread('riding_bomb.jpg');
%webcam_tool(@process_image, img)

% Processing a webcam stream (using default webcam)
webcam_tool(@process_image, 'webcam')

% Processing a camera stream (using training cameras)
%webcam_tool(@process_image, 'camera')