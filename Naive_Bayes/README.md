@author: Valentin Larrieu

# Naive Bayes

**Machine Learning Spam classification**

The goal of this study was to implement a python model do determine if a mail is a spam or not.

The Dataset we used is contained in the file &quot;message.txt&quot; which contains 4997 messages, one on each line being separed from the target (ham/spam) with a tabulation.

We then wrote our program to fulfil our goal to test the model in order to have the most effective prediction possible:

- We read the CSV and extract the features using the panda library
- We convert the string &quot;ham&quot;/&quot;spam&quot; to 0/1 (because we want to be able to use our target)
- We also take care of randomly shuffle the data to reduce the risk of presorted data (possible bias)
- We cut our set between training and test (80% and 20%)
- We contruct a dictionary using the messages we extracted
- We set and use our 2 models (Linear SVC &amp; MultinomialNB)
- We add one other model : the GaussianNB
- We evaluate the effectiveness off our models

Here is a sum up of the results:



| Model/ Score | **R2** | **F1** |
| --- | --- | --- |
| **Linear SVC** | 0.80745650037 | 0.98 |
| **MultinomialNB** | 0.736519421559 | 0.97 |
| **GaussianNB** | -0.753159233474 | 0.85 |

- The F1 score is 2\*(precision\*recal/precision+recall) it is an indicator on how good is our model to predict
- The R2 score show us how close are the data to the model we fitted on them
- As we can see here the GaussianNB seems to be the less effective model to predict the output. Indeed his f1 score is the lowest from our 3 models, that means he is a model doing more errors than the other on the predictions
- The results here show us that the best model for our data seems to be the linear SVC, since it has the best F1 score (it predicts well) and R2 score (the model is close the data