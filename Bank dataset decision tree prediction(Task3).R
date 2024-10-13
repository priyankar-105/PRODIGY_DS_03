data<-read.csv("C:/Users/priya/Downloads/Bank.csv")
str(data)
install.packages("rpart.plot")
library(rpart)
library(rpart.plot)
library(caret)
library(dplyr)
summary(data)
data$y<-as.factor(data$y)
#Split the data into training and testing sets(80% training 20% testing)
set.seed(123)
trainIndex<-createDataPartition(data$y,p=0.8,list=FALSE)
train_data<-data[trainIndex,]
test_data<-data[-trainIndex,]
#Build the decision tree classifier 
#the target variable is y(purchase decision) and the rest are predictors
tree_model<-rpart(y~.,data=train_data,method="class")
#visualize the decision tree
rpart.plot(tree_model)
#Make predictions on the test data
predictions<-predict(tree_model,test_data,type="class")
#Evaluate the model
confusion_matrix<-confusionMatrix(predictions,test_data$y)
print(confusion_matrix)
#Plot variable importance
importance<-varImp(tree_model)
print(importance)
