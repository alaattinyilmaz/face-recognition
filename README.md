# face-recognition
Computer Vision face recognition and reconstruction by PCA method

In this lab we will implement a system that reconstruct and recognize faces by use of
eigenfaces. But first, let me give some background information to understand the procedure
better.

As a starting point, we will treat an N x M image as a vector in NM-dimensional space (form
vector by collapsing rows from top to bottom into one long vector). Then we convert x into v1
and v2 coordinates. 

x = ((x-xbar).v1, (x-xbar).v2)

Where v1 measures distance for classification and v2 measures positon to specify the point. 
