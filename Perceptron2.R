###Perceptron playing

add_boundary <- function(w, color='red'){
  w <- as.numeric(w)  
  
  b = w[1]
  w1 = w[2]
  w2 = w[3]
  
  slope = -(w1/w2)
  intercept = -(b/w2)
  abline(a=intercept, b=slope, col=color)
}

activate <- function(df,w){ 
  #df should be of shape m x n
  #w should be of shape 1 x n
  activation <- apply(df, 1, function(x) sum(x*w))
  return(ifelse(activation > 0, 1, -1))
}


#### GENERATE THE DATA ####

#randomly choose the TRUE parameters
w_true <- runif(3, -5, 5)

#generate random data for classification
x0 <- rep(1, 30)
x1 <- runif(30, -10, 10)
x2 <- runif(30,-10,10)
df <- data.frame(x0, x1, x2) #put in a data frame

f_class <- activate(df, w_true) #get true classifications using w_true

#plot data
plot(x1,x2, col=factor(f_class))
add_boundary(w_true, color='blue')

#### LEARNING ####

#randomly initialize estimate parameters
w_guess <- runif(3, -.5, .5)
add_boundary(w_guess, color='green') #plot current hypothesis
g_class <- activate(df, w_guess) #stores classifications with current w_guess

## Start PLA ###

#max_iter <- 100 #maximum number of iterations
#n_misses <- rep(NA, 100) #because R

while(!all(g_class==f_class)){ #while there are mis-classifications
  
  #randomly choose a mis-classified example
  mis_classifs <- df[g_class != f_class,]  
  
  rand_choice <- if(nrow(mis_classifs)==1){
    as.numeric(rownames(mis_classifs))
  }else{
    sample(as.numeric(rownames(mis_classifs)),1) #choose one of the misclassed rows
  }
  
  #update the weights
  w_guess <- w_guess + f_class[rand_choice]*as.vector(mis_classifs[rownames(mis_classifs)==rand_choice,])
  
  g_class <- activate(df, w_guess)
  
  add_boundary(w_guess, color='pink')
  
  readline("Press <return> to continue") 
}