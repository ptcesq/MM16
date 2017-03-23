
# get original data 
library(RSQLite)
conn = dbConnect(RSQLite::SQLite(), dbname="./data/database.sqlite")
df <- dbGetQuery(conn, 'SELECT * FROM season_details')
df$outcome <- as.factor(df$outcome)
df$id <- as.factor(df$id)
df$loc <- as.factor(df$loc)
df$season <- as.factor(df$season)
df <- df[,-c(1, 3, 4)]

# create test and training sets 
inTrain <- sample(1:nrow(df), nrow(df) * 0.85) # select 85% of the items 
train <- df[inTrain, ]
test <- df[-inTrain, ]
rm(df, inTrain)

# Lets start with a standard glm 
model <- glm(train$outcome ~ ., data=train, family=binomial(link="logit"))
predicted <- predict(model, test, type=c("response" ))
results <- as.data.frame(cbind(test$outcome, predicted))
colnames(results) <- c("actual", "odds")
results$pred <- ifelse(results$odds < 0.5, 0, 1)
results$actual <- ifelse(results$actual == 2, 1, 0)

# Contingency Table 
library(gmodels)
with(results, CrossTable(actual, pred, prop.chisq=FALSE, 
                         prop.r=FALSE, prop.c=FALSE, prop.t=FALSE, 
                         format="SPSS"))


library(ROCR)
# precision recall graph 
pred <- prediction(results$pred, results$actual)


## computing a simple ROC curve (x-axis: fpr, y-axis: tpr)
perf <- performance(pred,"tpr","fpr")
auc.perf <- performance(pred, measure="auc")
auc.perf@y.values
ROC.Val <- auc.perf@y.values
main.label <- paste("ROC Curve - AUC=", ROC.Val)
plot(perf, colorize=TRUE, main=main.label)
abline(a=0, b=1)
