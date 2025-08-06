# Customer-Prediction-with-random-forest
This project uses supervised machine learning (Random Forest) to predict customer churn based on the IBM Telco Customer Churn dataset.

This project uses Random Forest, a supervised machine learning algorithm, to predict customer churn (i.e., whether a customer will cancel a telecom service). The dataset is provided by IBM and includes customer demographics, account info, and services used.

We run the entire training and evaluation process 10 times with random seeds to analyze how model performance varies due to randomness in training-test splits.






| Step             | Description                                     |
| ---------------- | ----------------------------------------------- |
| ✅ Load Data      | Import Telco churn dataset from IBM GitHub      |
| ✅ Clean Data     | Handle missing values and prepare data types    |
| ✅ Train Model    | Use Random Forest to predict churn              |
| ✅ Evaluate Model | Capture Accuracy and AUC (performance metrics)  |
| ✅ Repeat Process | Run model 10 times with different random splits |
| ✅ Visualize      | Plot variation in model performance             |
| ✅ Summarize      | Show how randomness affects results             |







What You Should Expect
Each run will produce slightly different results because the training/testing split is randomized every time.

Accuracy typically ranges between 0.78 – 0.82

AUC (Area Under Curve) ranges between 0.83 – 0.87

Some variation is normal and expected in supervised learning, especially when the dataset isn't very large or balanced.






Limitation	                                How We Addressed It
Results vary with random train/test splits	✅ Used 10 repeated runs to analyze variability
Possible bias from one split	              ✅ Aggregated results (Accuracy + AUC) for more reliable insights
Class imbalance (Churn = No dominant)	      ❗Could improve by using stratified sampling or SMOTE (future enhancement)
Not hyperparameter tuned	                  ❗Model could be further improved using caret::train() grid search


 
 
 Key Insights for Business or Hiring Managers
📈 Random Forest provides stable performance on this dataset, even with random sampling.

🔍 Key predictors of churn:

Contract type

Tenure (length of time as customer)

MonthlyCharges

OnlineSecurity

📉 Short-tenured, month-to-month customers with high monthly charges are most likely to churn

🔁 Randomized evaluation approach helps assess model reliability and trustworthiness
