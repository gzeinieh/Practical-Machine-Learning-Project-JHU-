# Practical-Machine-Learning-Project-JHU-

## About the project 

One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, the goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants.

## Background

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, your goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information is available from the website here: http://groupware.les.inf.puc-rio.br/har (see the section on the Weight Lifting Exercise Dataset).

## Data


### The training data for this project are available here:

https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv

### The test data are available here:

https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv

The data for this project come from this source: http://groupware.les.inf.puc-rio.br/har.

## Data Cleaning 

All user information, like username, are not useful for classe prediction, as well as columns with empty values. 

```R

DataT<- read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"),na.strings=c("","NA"))

DataT1 <- DataT[ , colSums(is.na(DataT)) == 0]

DataTfinal <- DataT1[,-c(1:8)]

```

## randomForest



```R

install.packages('randomForest')

library('randomForest')

```

spliting data and training the model 


```R

inTrain <- createDataPartition(DataTfinal$classe,list=FALSE)

training <- DataTfinal[inTrain,]

testing <- DataTfinal[-inTrain,]

modelfit <- randomForest(classe~., data=training, method='class')

```

testing the model ==> 99% accuracy

```
pred <- predict(modelfit,testing)

confusionMatrix(pred,testing$classe)`

## Confusion Matrix and Statistics

Reference
Prediction    A    B    C    D    E
A 2789   15    0    0    0
B    1 1880   27    0    0
C    0    3 1681   35    1
D    0    0    3 1573   11
E    0    0    0    0 1791

Overall Statistics

Accuracy : 0.9902          
95% CI : (0.9881, 0.9921)
     

Kappa : 0.9876          
Mcnemar's Test P-Value : NA              

Statistics by Class:

Class: A Class: B Class: C Class: D
Sensitivity            0.9996   0.9905   0.9825   0.9782
Specificity            0.9979   0.9965   0.9952   0.9983
Pos Pred Value         0.9947   0.9853   0.9773   0.9912
Neg Pred Value         0.9999   0.9977   0.9963   0.9957
Prevalence             0.2844   0.1935   0.1744   0.1639
Detection Rate         0.2843   0.1916   0.1714   0.1603
Detection Prevalence   0.2858   0.1945   0.1753   0.1618
Balanced Accuracy      0.9988   0.9935   0.9888   0.9883
Class: E
Sensitivity            0.9933
Specificity            1.0000
Pos Pred Value         1.0000
Neg Pred Value         0.9985
Prevalence             0.1838
Detection Rate         0.1826
Detection Prevalence   0.1826
Balanced Accuracy      0.9967

```

## prediction 

 

```R

DataV<- read.csv(url("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"),na.strings=c("","NA"))

DataV1 <- DataV[ , colSums(is.na(DataV)) == 0]

DataVfinal <- DataV1[,-c(1:8)]

predfinal <- predict(modelfit,DataVfinal) 

```

## final results 

```
1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 
B  A  B  A  A  E  D  B  A  A  B  C  B  A  E  E  A  B  B  B 
Levels: A B C D E

```





