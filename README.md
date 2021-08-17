# face-recognition
Computer Vision face recognition and reconstruction by PCA method.

All the required equations and procedure below is explained in my report detailly: https://github.com/alaattinyilmaz/face-recognition/blob/master/face-recognition.pdf

### Face Detection & Dataset

I will be given an image dataset consisting of 10 images (56×46) taken from different views of 40 people. You can use 9 images per person to build your model and the rest for testing its performance. Note that, in the given dataset the images are already flattened and concatenated therefore it has 2576 (56×46) columns and 400 rows. A sample of the dataset is shown in the figure below:

<img src="https://ww2.mathworks.cn/matlabcentral/mlc-downloads/downloads/submissions/45750/versions/1/screenshot.jpg" width="%40" height="%40">

### Face Reconstruction
We will use PCA method to achieve face reconstruction. This method introduces dimensionality reduction. The space of all faces is a “subspace” of the space of all images. We suppose that it has K dimension. This K is chosen by the most effective K largest
eigenvalues. Large eigenvalue shows the most variation in the face which represents the essential characteristics of the face. Then we compute small a coefficients as weights (a1,a2…) then we multiply them with the faces. Then after, we add xbar which is the mean of
the all faces in the training set. We can interpret that the reconstructed face is the weighted sum of the all faces plus mean characteristics of the face that seems really reasonable. In addition to these, we also determined a threshold value by subtracting mean of the faces from the constructed image. Norm of this error should be smaller than our threshold value in order
to be detected as a face. We chose threshold as 8 by experimentally.

<img src="https://i.ibb.co/G0xZDz2/reconstruction.png" width="60%" height="%60">

### Face Recognition

To achieve face recognition, we will create a database that consists of the descriptors of all the images in the training set (a1,a2…aK). Then we will compute the descriptor of the test image and find the Euclidian distance of it from all the values in the database. Then we will take the image with the smallest Euclidian distance. We can understand that if it has smaller distance, we have more similar features to that image. We also used different distance metric which is called Mahalanobis distance that uses also eigenvalues and sometimes gives better results in comparison with Euclidian distance. In order to recognize my face, I took 9 photos of myself from different angles and resized them to add to the training set. After training, I took another photo to test. At the end, the system could reconstruct and recognize my face correctly. (I also think that reconstruction has a poor quality.) We also got different correct results by Euclidian and Mahalanobis distance metrics which is quite interesting result for me. 

<img src="https://alaattinyilmaz.github.io/images/facerecognition.png" width="%60" height="%60">
