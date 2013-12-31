Here we take a look at one of the simplest learning algorithms in machine learning. At its simplest, a percetron takes a vector of inputs **x** = (x<sub>1</sub>, x<sub>2</sub>,...,x<sub>n</sub>), weights each component and outputs a single binary variable, "yes" or "no", depending on whether a weighted sum exceeds some threshold.

We can visualize our perceptron as a collection of inputs that are weighted to give a single output: !(Simple Perceptron)[https://github.com/billderose/perceptron/percep.jpg]

If we interpret the perceptron's decision boundary geometrically, we see itis exactly a hyperplane and thus our perpetron is really only good for classifying linearly separable data.