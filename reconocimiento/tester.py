import cv2
import os 
import numpy as np 
import app as fr

test_img=cv2.imread('test/wws.jpg')
print("Dimensiones originales: ", test_img.shape)
faces_detected,gray_img=fr.faceDetection(test_img)
print("faces_detected:",faces_detected)

# for (x,y,w,h) in faces_detected:
#     cv2.rectangle(test_img, (x,y),(x+w, y+h),(255,0,0),thickness=5)

# resized_img=cv2.resized_img(test_img,(1000,700))
# cv2.imshow("face dtection tutorial", test_img)
# cv2.waitKey(0)
# cv2.destroyAllWindows

# faces, faceID=fr.entrenamiento_data('entrenamiento')
# reconocedor_cara=fr.entrenador_clasificador(faces,faceID)
# reconocedor_cara.save('data.yml')

reconocedor_cara = cv2.face.LBPHFaceRecognizer_create()
reconocedor_cara.read('data.yml')
name={0:"gene"}
for face in faces_detected:
    (x,y,w,h)=face
    roi_gray=gray_img[y:y+h,x:x+h]
    label,confidence=reconocedor_cara.predict(roi_gray)
    print("concidence:",confidence)
    print("label:",label)
    fr.draw_rect(test_img,face)
    predicted_name=name[label]
    print(predicted_name)
    if(confidence>20):#If confidence more than 37 then don't print predicted face text on screen
        continue
    fr.put_text(test_img,predicted_name,x,y)
      
cv2.imshow("face dtection tutorial", test_img)
cv2.waitKey(0)
cv2.destroyAllWindows       

    