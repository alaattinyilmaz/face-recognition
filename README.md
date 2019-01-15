# face-recognition
Computer Vision face recognition and reconstruction by PCA method.
All the equation and procedure below is explained in my report detailly: https://github.com/alaattinyilmaz/face-recognition/blob/master/face-recognition.pdf

### Background Information
As a starting point, we will treat an N x M image as a vector in NM-dimensional space (form
vector by collapsing rows from top to bottom into one long vector). Then I convert x into v1
and v2 coordinates. Where v1 measures distance for classification and v2 measures positon to specify the point. 

x = ((x-xbar).v1, (x-xbar).v2)

### Face Detection & Dataset

I will be given an image dataset consisting of 10 images (56×46) taken from different views of 40 people. You can use 9 images per person to build your model and the rest for testing its performance. Note that, in the given dataset the images are already flattened and concatenated therefore it has 2576 (56×46) columns and 400 rows. A sample of the dataset is shown in the figure below:

![Dataset](https://serving.photos.photobox.com/6625699650dc2722c0381af797e170aa2b3f2f53523fbcc406d459439c708d4b8e2b9bd6.jpg)

### Face Reconstruction
We will use PCA method to achieve face reconstruction. This method introduces dimensionality reduction. The space of all faces is a “subspace” of the space of all images. We suppose that it has K dimension. This K is chosen by the most effective K largest
eigenvalues. Large eigenvalue shows the most variation in the face which represents the essential characteristics of the face. Then we compute small a coefficients as weights (a1,a2…) then we multiply them with the faces. Then after, we add xbar which is the mean of
the all faces in the training set. We can interpret that the reconstructed face is the weighted sum of the all faces plus mean characteristics of the face that seems really reasonable. In addition to these, we also determined a threshold value by subtracting mean of the faces from the constructed image. Norm of this error should be smaller than our threshold value in order
to be detected as a face. We chose threshold as 8 by experimentally.

### Face Recognition

To achieve face recognition, we will create a database that consists of the descriptors of all the images in the training set (a1,a2…aK). Then we will compute the descriptor of the test image and find the Euclidian distance of it from all the values in the database. Then we will take the image with the smallest Euclidian distance. We can understand that if it has smaller distance, we have more similar features to that image. We also used different distance metric which is called Mahalanobis distance that uses also eigenvalues and sometimes gives better results in comparison with Euclidian distance. In order to recognize my face, I took 9 photos of myself from different angles and resized them to add to the training set. After training, I took another photo to test. At the end, the system could reconstruct and recognize my face correctly. (I also think that reconstruction has a poor quality.) We also got different correct results by Euclidian and Mahalanobis distance metrics which is quite interesting result for me. 

![My Face](https://serving.photos.photobox.com/66796245f027d1ee94755fa4e7319f8f3b51767a75bec389004448052efb0c16d4a84790.jpg)
