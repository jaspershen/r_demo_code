## https://www.shanelynn.ie/self-organising-maps-for-customer-segmentation-using-r/

rm(list = ls())
# Creating Self-organising maps in R
# Load the kohonen package 
require(kohonen)
data("wines")
# Create a training data set (rows are samples, columns are variables
# Here I am selecting a subset of my variables available in "data"
data_train <- data[, c(2,4,5,8)]
data_train <- wines

# Change the data frame with training data to a matrix
# Also center and scale all variables to give them equal importance during
# the SOM training process. 
data_train_matrix <- as.matrix(scale(data_train))

# Create the SOM Grid - you generally have to specify the size of the 
# training grid prior to training the SOM. Hexagonal and Circular 
# topologies are possible
som_grid <- somgrid(xdim = 5, ydim = 5, topo="hexagonal")

# Finally, train the SOM, options for the number of iterations,
# the learning rates, and the neighbourhood are available
som_model <- som(data_train_matrix, 
                 grid=som_grid, 
                 rlen=3000, 
                 alpha=c(0.05,0.01), 
                 keep.data = TRUE)

#Training progress for SOM
plot(som_model, type="changes")

#Node count plot
plot(som_model, type="count", main="Node Counts", shape = "straight")

# U-matrix visualisation
plot(som_model, type="dist.neighbours", 
     main = "SOM neighbour distances",shape = "straight")


# Weight Vector View
plot(som_model, type="codes",shape = "straight")


# Kohonen Heatmap creation
plot(som_model, type = "property", 
     property = getCodes(som_model)[,2], 
     main=colnames(getCodes(som_model))[2]
     # palette.name=coolBlueHotRed
)
