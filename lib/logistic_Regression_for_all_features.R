# Finding the test_index
sift_features<-read.csv("sift_features.csv",header = TRUE)
sift_features<-data.frame(t(sift_features))
n<-dim(sift_features)[1]
sift_features$image<-seq(1:n)
library(dplyr)
test_data<-read.csv("prediction_inceptionV3.csv")
test_data<-data.frame(test_data)
test_data<-sift_features%>%filter(paste(rownames(sift_features),".jpg",sep="")%in%test_data$image)
test_index<- test_data$image



# Orignial Data Frame including the Class label---Correct rate: 0.495:
sift_features<-read.csv("sift_features.csv",header = TRUE)
sift_features<-data.frame(t(sift_features))
class<-read.csv("labels.csv")
class<-unlist(class)
sift_features$Class<-factor(class)

# Separete trainning data and test data from orignial data set
train_data<-sift_features[-test_index,]
test_data<-sift_features[test_index,]

# Orignal 5000 feature fro logistical regression model
logisticRegression_1<-glm(Class~.,data=train_data,family = "binomial")

# Prediction result for test data
Prediction_LogisticRegression_sift<-predict(logisticRegression_1,test_data,type = "response")

# Correct prediction rate for test data:
logResTest<-ifelse(Prediction_LogisticRegression_sift>0.5,1,0)
sum(logResTest==class[test_index])/length(logResTest)

# Generate file
Prediction_LogisticRegression_sift<-data.frame(Prediction_LogisticRegression_sift)
colnames(Prediction_LogisticRegression_sift)<-"labradoodle"
Prediction_LogisticRegression_sift$image<-rownames(Prediction_LogisticRegression_sift)
Prediction_LogisticRegression_sift$friedChicken<-1-Prediction_LogisticRegression_sift$labradoodle

write.csv(Prediction_LogisticRegression_sift,file = "prediction_LogisticRegression_sift.csv")

# do feture selection for sift 5000 logistic regression by LASSO, correct rate: 0.71:
if(!require("glmnet")) install.packages('glmnet')
library("glmnet")

logictRegression_sift_featureSelect<-cv.glmnet(as.matrix(train_data[,1:5000]),train_data$Class,alpha = 1,family = "binomial",type.measure='auc')
Prediction_LogisticRegression_sift_featureSelect<- predict(logictRegression_sift_featureSelect,newx  = as.matrix(test_data[,1:5000]),type = "response",s='lambda.min')
logResTest<-ifelse(Prediction_LogisticRegression_sift_featureSelect>0.5,1,0)
sum(logResTest==class[test_index])/length(logResTest)

# Generate file sift_featureSelection
Prediction_LogisticRegression_sift_featureSelect<-data.frame(Prediction_LogisticRegression_sift_featureSelect)
colnames(Prediction_LogisticRegression_sift_featureSelect)<-"labradoodle"
Prediction_LogisticRegression_sift_featureSelect$image<-rownames(Prediction_LogisticRegression_sift_featureSelect)
Prediction_LogisticRegression_sift_featureSelect$friedChicken<-1-Prediction_LogisticRegression_sift_featureSelect$labradoodle
write.csv(Prediction_LogisticRegression_sift_featureSelect,file = "prediction_LogisticRegression_sift_featureSelect.csv")







# Logsitical regression based on PCA 1000---Correct rate: 0.65

write.csv(Prediction_LogisticRegression_sift,file = "Prediction_LogisticRegression_sift.csv")



# Logsitical regression based on PCA---Correct rate: 0.65


sift_features<-read.csv("sift_features_1000.csv",header = TRUE)
sift_features<-data.frame(t(sift_features))
sift_features$Class<-class
test_data<-sift_features[test_index,]
train_data<-sift_features[-test_index,]
logisticRegression_PCA<-glm(Class~.,data=train_data,family = "binomial")


# Prediction result for test data
Prediction_LogisticRegression_sift1000<-predict(logisticRegression_PCA,test_data,type = "response")

# Correct prediction rate for test data:
logResTest<-ifelse(Prediction_LogisticRegression_sift1000>0.5,1,0)
sum(logResTest==class[test_index])/length(logResTest)

# Generate file
Prediction_LogisticRegression_sift1000<-data.frame(Prediction_LogisticRegression_sift1000)
colnames(Prediction_LogisticRegression_sift1000)<-"labradoodle"
Prediction_LogisticRegression_sift1000$image<-rownames(Prediction_LogisticRegression_sift1000)
Prediction_LogisticRegression_sift1000$friedChicken<-1-Prediction_LogisticRegression_sift1000$labradoodle
write.csv(Prediction_LogisticRegression_sift1000,file = "prediction_LogisticRegression_sift1000.csv")

# do feture selection for sift1000 logistic regression by LASSO, correct rate: 0.7625:
if(!require("glmnet")) install.packages('glmnet')
library("glmnet")

logictRegression_sift1000_featureSelect<-cv.glmnet(as.matrix(train_data[,1:1000]),train_data$Class,alpha = 1,family = "binomial",type.measure='auc')
Prediction_LogisticRegression_sift1000_featureSelect<- predict(logictRegression_sift1000_featureSelect,newx  = as.matrix(test_data[,1:1000]),type = "response",s='lambda.min')
logResTest<-ifelse(Prediction_LogisticRegression_sift1000_featureSelect>0.5,1,0)
sum(logResTest==class[test_index])/length(logResTest)

# Generate file sift_featureSelection
Prediction_LogisticRegression_sift1000_featureSelect<-data.frame(Prediction_LogisticRegression_sift1000_featureSelect)
colnames(Prediction_LogisticRegression_sift1000_featureSelect)<-"labradoodle"
Prediction_LogisticRegression_sift1000_featureSelect$image<-rownames(Prediction_LogisticRegression_sift1000_featureSelect)
Prediction_LogisticRegression_sift1000_featureSelect$friedChicken<-1-Prediction_LogisticRegression_sift1000_featureSelect$labradoodle
write.csv(Prediction_LogisticRegression_sift1000_featureSelect,file = "prediction_LogisticRegression_sift1000_featureSelect.csv")





# Prediction result for test data
Prediction_LogisticRegression_sift1000<-predict(logisticRegression_PCA,test_data,type = "response")

# Correct prediction rate for test data:
logResTest<-ifelse(Prediction_LogisticRegression_sift1000>0.5,1,0)
sum(logResTest==class[test_index])/length(logResTest)

# Generate file
Prediction_LogisticRegression_sift1000<-data.frame(Prediction_LogisticRegression_sift1000)
colnames(Prediction_LogisticRegression_sift1000)<-"labradoodle"
Prediction_LogisticRegression_sift1000$image<-rownames(Prediction_LogisticRegression_sift1000)
Prediction_LogisticRegression_sift1000$friedChicken<-1-Prediction_LogisticRegression_sift1000$labradoodle
write.csv(Prediction_LogisticRegression_sift1000,file = "Prediction_LogisticRegression_sift1000.csv")



# CNN model---Correction rate: 0.5425
sift_features<-read.csv("cnn_features.csv",header = TRUE)
sift_features<-data.frame(t(sift_features))
sift_features$Class<-factor(class)
test_data<-sift_features[test_index,]
train_data<-sift_features[-test_index,]
logisticRegression_cnn<-glm(Class~.,data=train_data,family = "binomial")

# Prediction result for test data
Prediction_LogisticRegression_cnn<-predict(logisticRegression_PCA,test_data,type = "response")

# Correct prediction rate for test data:
logResTest<-ifelse(Prediction_LogisticRegression_cnn>0.5,1,0)

sum(logResTest==class[test_index])/length(logResTest)

# Generate file
Prediction_LogisticRegression_cnn<-data.frame(Prediction_LogisticRegression_cnn)
colnames(Prediction_LogisticRegression_cnn)<-"labradoodle"
Prediction_LogisticRegression_cnn$image<-rownames(Prediction_LogisticRegression_cnn)
Prediction_LogisticRegression_cnn$friedChicken<-1-Prediction_LogisticRegression_cnn$labradoodle
write.csv(Prediction_LogisticRegression_cnn,file = "prediction_LogisticRegression_cnn.csv")

# do feture selection for cnn logistic regression by LASSO, correct rate: 0.95:
if(!require("glmnet")) install.packages('glmnet')
library("glmnet")

logictRegression_cnn_featureSelect<-cv.glmnet(as.matrix(train_data[,1:2048]),train_data$Class,alpha = 1,family = "binomial",type.measure='auc')
Prediction_LogisticRegression_cnn_featureSelect<- predict(logictRegression_cnn_featureSelect,newx  = as.matrix(test_data[,1:2048]),type = "response",s='lambda.min')
logResTest<-ifelse(Prediction_LogisticRegression_cnn_featureSelect>0.5,1,0)
sum(logResTest==class[test_index])/length(logResTest)

# Generate file sift_featureSelection
Prediction_LogisticRegression_cnn_featureSelect<-data.frame(Prediction_LogisticRegression_cnn_featureSelect)
colnames(Prediction_LogisticRegression_cnn_featureSelect)<-"labradoodle"
Prediction_LogisticRegression_cnn_featureSelect$image<-rownames(Prediction_LogisticRegression_cnn_featureSelect)
Prediction_LogisticRegression_cnn_featureSelect$friedChicken<-1-Prediction_LogisticRegression_cnn_featureSelect$labradoodle
write.csv(Prediction_LogisticRegression_cnn_featureSelect,file = "prediction_LogisticRegression_cnn_featureSelect.csv")









# CNN model 150 feature---Correstion Rate:0.9075:
sift_features<-read.csv("cnn_features_150.csv",header = TRUE)
sift_features<-data.frame(t(sift_features))
sift_features$Class<-factor(class)

# Separete trainning data and test data from orignial data set
train_data<-sift_features[-test_index,]
test_data<-sift_features[test_index,]

# Tarin Model
logistic.fit <- glm(Class ~ ., data = train_data, family = "binomial")
Prediction_LogisticRegression_cnn150 <- predict(logistic.fit,newdata = test_data,type = 'response')
logResTest<-ifelse(Prediction_LogisticRegression_cnn150>0.5,1,0)
sum(logResTest==class[test_index])/length(logResTest)

# Generate file cnn150
Prediction_LogisticRegression_cnn150<-data.frame(Prediction_LogisticRegression_cnn150)
colnames(Prediction_LogisticRegression_cnn150)<-"labradoodle"
Prediction_LogisticRegression_cnn150$image<-rownames(Prediction_LogisticRegression_cnn150)
Prediction_LogisticRegression_cnn150$friedChicken<-1-Prediction_LogisticRegression_cnn150$labradoodle
write.csv(Prediction_LogisticRegression_cnn150,file = "prediction_LogisticRegression_cnn150.csv")


# do feture selection for cnn150 logistic regression by LASSO, correct rate: 0.955:
if(!require("glmnet")) install.packages('glmnet')
library("glmnet")

logictRegression_cnn150_featureSelect<-cv.glmnet(as.matrix(train_data[,1:150]),train_data$Class,alpha = 1,family = "binomial",type.measure='auc')
Prediction_LogisticRegression_cnn150_featureSelect<- predict(logictRegression_cnn150_featureSelect,newx  = as.matrix(test_data[,1:150]),type = "response",s='lambda.min')
logResTest<-ifelse(Prediction_LogisticRegression_cnn150_featureSelect>0.5,1,0)
sum(logResTest==class[test_index])/length(logResTest)


# Generate file cnn150_featureSelection
Prediction_LogisticRegression_cnn150_featureSelect<-data.frame(Prediction_LogisticRegression_cnn150_featureSelect)
colnames(Prediction_LogisticRegression_cnn150_featureSelect)<-"labradoodle"
Prediction_LogisticRegression_cnn150_featureSelect$image<-rownames(Prediction_LogisticRegression_cnn150_featureSelect)
Prediction_LogisticRegression_cnn150_featureSelect$friedChicken<-1-Prediction_LogisticRegression_cnn150_featureSelect$labradoodle
write.csv(Prediction_LogisticRegression_cnn150_featureSelect,file = "prediction_LogisticRegression_cnn150_featureSelect.csv")




sum(logResTest==class[test_index])/length(logResTest)

# Generate file
Prediction_LogisticRegression_cnn<-data.frame(Prediction_LogisticRegression_cnn)
colnames(Prediction_LogisticRegression_cnn)<-"labradoodle"
Prediction_LogisticRegression_cnn$image<-rownames(Prediction_LogisticRegression_cnn)
Prediction_LogisticRegression_cnn$friedChicken<-1-Prediction_LogisticRegression_cnn$labradoodle
write.csv(Prediction_LogisticRegression_cnn,file = "Prediction_LogisticRegression_cnn.csv")


# CNN model 150 feature---Correstion Rate:0.9075:
sift_features<-read.csv("cnn_features_150.csv",header = TRUE)
sift_features<-data.frame(t(sift_features))
sift_features$Class<-factor(class)

# Separete trainning data and test data from orignial data set
train_data<-sift_features[-test_index,]
test_data<-sift_features[test_index,]

# Tarin Model
logistic.fit <- glm(Class ~ ., data = train_data, family = "binomial")
Prediction_LogisticRegression_cnn150 <- predict(logistic.fit,newdata = test_data,type = 'response')
logResTest<-ifelse(Prediction_LogisticRegression_cnn150>0.5,1,0)
sum(logResTest==class[test_index])/length(logResTest)

# Generate file
Prediction_LogisticRegression_cnn150<-data.frame(Prediction_LogisticRegression_cnn150)
colnames(Prediction_LogisticRegression_cnn150)<-"labradoodle"
Prediction_LogisticRegression_cnn150$image<-rownames(Prediction_LogisticRegression_cnn150)
Prediction_LogisticRegression_cnn150$friedChicken<-1-Prediction_LogisticRegression_cnn150$labradoodle
write.csv(Prediction_LogisticRegression_cnn150,file = "Prediction_LogisticRegression_cnn150.csv")





