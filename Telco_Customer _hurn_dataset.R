# 📦 Step 1: Install & Load Packages
install.packages(c("tidyverse", "caret", "randomForest", "pROC", "broom"))
packages <- c("tidyverse", "caret", "randomForest", "pROC", "broom")
lapply(packages, library, character.only = TRUE)
#Data manipulation (tidyverse)
#Machine learning & evaluation (caret, randomForest, pROC)
#Clean output formatting (broom)



# 📁 Step 2: Load Dataset from IBM GitHub
url <- "https://raw.githubusercontent.com/IBM/telco-customer-churn-on-icp4d/master/data/Telco-Customer-Churn.csv"
df <- read.csv(url)
#🔹 Loads the Telco Customer Churn dataset directly from IBM's GitHub repository.



# 🧹 Step 3: Data Cleaning
df$customerID <- NULL
df$TotalCharges <- as.numeric(as.character(df$TotalCharges))
df <- df[complete.cases(df), ]
df <- df %>% mutate_if(is.character, as.factor)
#Removes irrelevant customerID column
#Converts TotalCharges to numeric
#Removes rows with missing values
#Converts all character columns to categorical factors



# 📊 Step 4: Initialize storage for results
results <- data.frame(Run = 1:10, Accuracy = NA, AUC = NA)
# Prepares a table to store accuracy and AUC results for 10 runs.



# 🔁 Step 5: Repeat training & evaluation 10 times with random seeds
for (i in 1:10) {
  cat("Running iteration", i, "\n")
  
  # Random seed for each run
  set.seed(sample(1:10000, 1))
  
  # Train-test split
  split <- createDataPartition(df$Churn, p = 0.8, list = FALSE)
  train <- df[split, ]
  test <- df[-split, ]
  
  # Train Random Forest
  model_rf <- randomForest(Churn ~ ., data = train, ntree = 200)
  
  # Predict
  pred_rf <- predict(model_rf, test)
  prob_rf <- predict(model_rf, test, type = "prob")[, 2]
  
  # Evaluate
  cm <- confusionMatrix(pred_rf, test$Churn)
  roc_obj <- roc(test$Churn, prob_rf)
  
  # Store results
  results$Accuracy[i] <- cm$overall['Accuracy']
  results$AUC[i] <- auc(roc_obj)
}
#🔹 This loop runs the full ML process 10 times:
#Random train/test split each time
#New Random Forest model trained
#Predictions made on new test set
#Accuracy and AUC stored
#🔁 Every run gives slightly different results due to randomness — a common characteristic of supervised learning if the seed is not fixed.


# 📈 Step 6: Plot Accuracy and AUC across runs
library(ggplot2)

# Accuracy plot
ggplot(results, aes(x = Run, y = Accuracy)) +
  geom_line(color = "steelblue") +
  geom_point(size = 2) +
  labs(title = "Accuracy Across 10 Random Runs", y = "Accuracy", x = "Run")

# AUC plot
ggplot(results, aes(x = Run, y = AUC)) +
  geom_line(color = "darkred") +
  geom_point(size = 2) +
  labs(title = "AUC Across 10 Random Runs", y = "AUC", x = "Run")

#🔹 Visualizes how model performance fluctuates due to different data splits.
#A helpful diagnostic for understanding how stable and reliable the model is.

# 📊 Step 7: Show summary of variability
summary(results)
#🔹 Shows mean, min, max, quartiles of accuracy and AUC across the 10 runs.
#Gives a concise picture of performance variability.