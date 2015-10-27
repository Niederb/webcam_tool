A simple Matlab tool to quickly evaluate parameters image processing algorithms.

The tool supports three different modes: camera, webcam, image
camera und webcam erzeugen einen Live-Stream von einer Kamera während image nur ein einzelnes Bild anzeigt.

webcam_tool(@process_image, 'camera')
webcam_tool(@process_image, 'webcam')
webcam_tool(@process_image, img)

process_image is a handle to a function with the following signature:
function process_image(image, cb1_val, cb2_val, p1_val, p2_val, p3_val)

