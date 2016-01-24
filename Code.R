# getting and cleaning data

DataT<- read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"),na.strings=c("","NA"))

DataT1 <- DataT[ , colSums(is.na(DataT)) == 0]; DataTfinal <- DataT1[,-c(1:8)];



install.packages('randomForest'); library(randomForest); libaray(caret);

# data spliting

inTrain <- createDataPartition(DataTfinal$classe,list=FALSE)

training <- DataTfinal[inTrain,]

testing <- DataTfinal[-inTrain,]

# training with randomforest 

modelfit <- randomForest(classe~., data=training, method='class')

# testing

pred <- predict(modelfit,testing)

confusionMatrix(pred,testing$classe)

# prediction

DataV<- read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"),na.strings=c("","NA"))

DataV1 <- DataV[ , colSums(is.na(DataV)) == 0]

DataVfinal <- DataV1[,-c(1:8)]

predfinal <- predict(modelfit,DataVfinal) 

