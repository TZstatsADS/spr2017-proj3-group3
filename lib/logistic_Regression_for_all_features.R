
sift_features<-read.csv("sift_features.csv",header = TRUE)
sift_features<-data.frame(t(sift_features))
colnames(sift_features)<-seq(1,5000)
class<-read.csv("labels.csv")
class<-unlist(class)
sift_features$Class<-class
# take 20% of the data set as test data, which is 2000*0.2=400
n<-dim(sift_features)[1]
set.seed(400)
test_index<-sample(1:n,400)
test_data<-sift_features[test_index,]
train_data<-sift_features[-test_index,]
logisticRegression_1<-glm(Class~.,data=train_data,family = binomial(link='logit'))
logResTrain<-ifelse(sign(predict(logisticRegression_1))>0,1,0)

# Correct prediction rate for train data:
sum(logResTrain==class[-test_index])/length(logResTrain)

# Error  rate for train data:
1-sum(logResTrain==class[-test_index])/length(logResTrain)

# Prediction result for test data
logResTest<-ifelse(sign(predict(logisticRegression_1,test_data))>0,1,0)

# Correct prediction rate for test data:
sum(logResTest==class[test_index])/length(logResTest)

# Error rate for test data:
1-sum(logResTest==class[test_index])/length(logResTest)



# Improve the model by doing boostrap