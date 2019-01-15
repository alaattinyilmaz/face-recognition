# face-recognition
Computer Vision face recognition and reconstruction by PCA method

In this lab we will implement a system that reconstruct and recognize faces by use of
eigenfaces. But first, let me give some background information to understand the procedure
better.

As a starting point, we will treat an N x M image as a vector in NM-dimensional space (form
vector by collapsing rows from top to bottom into one long vector). Then we convert x into v1
and v2 coordinates. 

![\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}](https://latex.codecogs.com/svg.latex?x%3D%5Cfrac%7B-b%5Cpm%5Csqrt%7Bb%5E2-4ac%7D%7D%7B2a%7D)


Where v1 measures distance for classification and v2 measures positon to specify the point. 
