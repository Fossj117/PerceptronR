## Perceptron in R
## Jeff Fossett
## https://github.com/Fossj117/PerceptronR

########### HELPER FUNCTIONS #############

add_boundary <- function(w, color='red'){
  # Plot decision boundary defined by 
  # a parameter vector w
  
  w <- as.numeric(w)  
  
  b = w[1]
  w1 = w[2]
  w2 = w[3]
  
  slope = -(w1/w2)
  intercept = -(b/w2)
  abline(a=intercept, b=slope, col=color)
}

activate <- function(df,w){ 
  # returns current classifications on data 
  # for a given set of params, w
  # 
  # df should be of shape m x n
  # w should be of shape 1 x n
  
  activation <- apply(df, 1, function(x) sum(x*w))
  return(ifelse(activation > 0, 1, -1))
}

random_row <- function(mis_classifs){
  # select a random row number from a 
  # data frame of choices
  
  rand_choice <- if(nrow(mis_classifs)==1){ #if there is only one misclassification, choose it
    as.numeric(rownames(mis_classifs))
  }else{ #otherwise, choose randomly from the misclassified rows
    sample(as.numeric(rownames(mis_classifs)),1) 
  }
  return(rand_choice)
}

################ GENERATE THE DATA ##############################

NUMPTS = 100 
SEED = 117

#randomly choose the TRUE separator
w_true <- runif(3, -5, 5)

#generate random data for classification
x0 <- rep(1, NUMPTS)
x1 <- runif(NUMPTS, -10, 10)
x2 <- runif(NUMPTS,-10,10)
df <- data.frame(x0, x1, x2) #put in a data frame

#get true classifications using w_true
f_class <- activate(df, w_true) 

#plot data
plot(x1,x2, col=factor(f_class))
add_boundary(w_true, color='blue')

##################### LEARNING ##########################

#randomly initialize w_guess = current hypothesis: 
w_guess <- runif(3, -.5, .5)

#plot current hypothesis
#add_boundary(w_guess, color='green') 

#get classifications for current w_guess:
g_class <- activate(df, w_guess) 

##### Start Perceptron Learning Algorithm #######

num_iterations <- 0

while(!all(g_class==f_class)){ #while there are mis-classifications
  
  #store the number of iterations
  num_iterations <- num_iterations + 1
  
  #randomly choose a mis-classified example
  mis_classifs <- df[g_class != f_class,]  
  rand_choice <- random_row(mis_classifs)
  
  #update the weights
  w_guess <- w_guess + f_class[rand_choice]*as.vector(mis_classifs[rownames(mis_classifs)==rand_choice,])
  
  #update predictions with new boudary (and plot)
  g_class <- activate(df, w_guess)
  
  #plot(x1,x2, col=factor(f_class))
  add_boundary(w_guess, color='pink')
  
  #pause before next iteration
  #readline("Press <return> to continue") 
}

print(paste("Converged in", num_iterations, "iterations"))
add_boundary(w_guess, color='red') #plot final boundary


