library(rgl)

# Random.Unit returns n dim-dimensional points in the unit interval labeled
# -1 or 1. The label depends on whether or not the sum of the vector's 
# components exceeds the given threshold. That is, -1 if sum(vector) < threshold
# and 1 otherwise.
Random.Unit <-function(n, dim, threshold) {
  points <- runif(n * dim)
  points <- matrix(points, ncol = dim)
  label <- ifelse(apply(points, 1, sum) < threshold, -1, 1)
  return(cbind(label, x0 = rep(1, n), points))
}

# Classify is our simple classification rule for the perceptron.We simply 
# return the sign of the dot-product of our observations and weights
Classify <- function(x, weights) {
  return(sign(x %*% weights))
}

# Perceptron is a simple implementation of the perceptron learning algorithm.
# It accepts data of the form data[1] = label, data[2] = x_0 = 1, data[3] = x_1,
# etc. w0 is initilized to -threshold and the weights returned are such that
# sign(w_0 * x_0 + w_1 * x_1 + ... + w_n * x_n) == label
Perceptron <- function(data, threshold) {
  w <- c(-threshold, runif(ncol(data) - 2))
  n <- nrow(data)
  label <- data[ , 1]
  obs <- data[ , 2:ncol(data)]
  misclassfied <- TRUE
  epocs <- 0
  while (misclassfied) {
    misclassfied <- FALSE
    for (i in 1:n) {
      if (label[i] * Classify(obs[i , ], w) <= 0) {
        w <- (w + label[i]) * as.numeric(obs[i , ])
        misclassfied <- TRUE
      }
    }
    epocs <- epocs + 1
  }
  print(paste("EPOCs: ", as.character(epoc)))
  return(w)
}

# Plot3D is essentially a wrapper for the rgl package's plot3d function.
# It plots the result of a call to Random.Unit with dim = 3
# as well as the plane parameterized by ax + by + cz + d = 0
Plot3D <- function(points, a, b, c, d) {
  plot3d(points[, 3:5], xlab = "X", ylab = "Y", zlab = "Z",
         pch = ifelse(points[, 1] == 1, 2, 8),
         col = ifelse(points[, 1] == 1, "blue", "red"))
  planes3d(a, b, c, d)
}

# Plot2D plots the result of a call to Random.Unit with dim = 2 as well
# as the line parameterized by y = bx + a, as in the call to abline.
Plot2D <- function(points, a, b) {
  plot(points[, 3:4], xlab = "X", ylab = "Y",
       pch = ifelse(points[, 1] == 1, 2, 8),
       col = ifelse(points[, 1] == 1, "blue", "red"))
  abline(a, b)
}

THRESHOLD <- 1.5
pts <- Random.Unit(1000, 3, THRESHOLD)
Plot3D(pts, 1, 1, 1, -THRESHOLD)
w <- Perceptron(pts, THRESHOLD)
Plot3D(pts, w[4], w[3], w[2], w[1])

THRESHOLD <- 0.75
pts <- Random.Unit(1000, 2, THRESHOLD)
Plot2D(pts, THRESHOLD, -1)
w <- Perceptron(pts, THRESHOLD)
Plot2D(pts, -w[1]/w[3], -w[2]/ w[3])