# k-Means-racket
## What is k-Means-Clustering?
A machine learning algorithm for seperating data into clusters.

example:
* points are sports players, lying in 4 dimensional space
 * one dimension is height
 * one dimension is sprint speed
 * one dimension is marathon time
 * one dimension is max bench press weight
Then the algorithm breaks these points into clusters.  A cluster might be soccer players, but the algorithm does not know that. It just tells you this clump of points is alike.

I learned about it [here](http://jeremykun.com/2013/02/04/k-means-clustering-and-birth-rates/). You can learn about it [here](https://en.wikipedia.org/wiki/K-means_clustering).
## How to use code?
`k-means.rkt` provides a function called `cluster`. Pass it a list of points and a number k. It returns the list of clusters. If a cluster is empty, it will not be included in the list.
