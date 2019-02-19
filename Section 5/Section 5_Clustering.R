
library(datasets)
head(iris)


#***************************************
#******* Hierarchical Clustering *******
#***************************************
?hclust

dist1 <- dist(iris[, 1:4])
#View(as.matrix(dist1))
clusters <- hclust(dist1)
plot(clusters)
clusterCut <- cutree(clusters, 3)
table(clusterCut, iris$Species)



#***************************************
#************* K means     *************
#***************************************
#install.packages("ggplot2")
library(ggplot2)
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()


set.seed(20) # Setting the seed to ensure reproductibility 
irisCluster <- kmeans(iris[, 1:4], 3, nstart = 20)
irisCluster


table(iris$Species)

#Lets see what species fall into which clusters: 
table(irisCluster$cluster, iris$Species)

