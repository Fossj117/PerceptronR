#### Perceptron in R

Simple implementation/demo of the perceptron (and the perceptron learning algorithm) in R. Coded for [*Learning From Data*](https://work.caltech.edu/telecourse.html) (Mostafa et al.) work-through. 

The `Perceptron2.R` script will do the following: 

**Generate Data**: 

* Randomly generate and plot a linearly-separable dataset of size `NUMPTS` (with different color points for each class); default for `NUMPTS` is 100. 
* Plot the "true" decision boundary for the dataset in blue. 

**Learning**: 

* Run the Perceptron Learning Algorithm (PLA) from a randomly-initialized decision boundary. 
*  Plot (in pink) PLA decision boundary iterations.
*  Upon convergence, script will plot the final decision boundary (learned by PLA) in blue and print the number of iterations required for convergence. 