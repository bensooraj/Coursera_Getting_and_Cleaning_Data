# UCI HAR Dataset Tidy Dataset - Codebook
---

### Dataset Used:

#####[Human Activity Recognition Using Smartphones Dataset v1.0](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
##### Downloaded from [UCI HAR Dataset](https%3A%2F%2Fd396qusza40orc.cloudfront.net%2Fgetdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Variables Used:

<table>
  <tr>
    <th>Variable Name</th>
    <th>Dimension</th>
    <th>Purpose</th>
  </tr>
  <tr>
    <td>features</td>
    <td>561 x 2</td>
    <td>561 features selected from the accelerometer and gyroscope 3-axial raw signals</td>
  </tr>
  <tr>
    <td>activity_labels</td>
    <td>6 x 2</td>
    <td>1 - Walking, 2 - Walking_Upstairs
, <br>3 - Walking_Downstairs, 4 - Sitting, <br>5 - Standing and 6 - Laying</td>
  </tr>
  <tr>
    <td>X_train</td>
    <td>7352 x 561</td>
    <td>Training set</td>
  </tr>
  <tr>
    <td>Y_train</td>
    <td>7352 x 1</td>
    <td>Activity labels for the training set(1 to 6)</td>
  </tr>
  <tr>
    <td>subject_train</td>
    <td>7352 x 1</td>
    <td>Participant labels for the training set</td>
  </tr>
  <tr>
    <td>trainDataTemp</td>
    <td>7352 x 562</td>
    <td>Activity + 561 features. For the training set.</td>
  </tr>
  <tr>
    <td>trainDataFinal</td>
    <td>7352 x 563</td>
    <td>Subject + Activity + 561 features. For the training set.</td>
  </tr>
  <tr>
    <td>X_test</td>
    <td>2947 x 561</td>
    <td>Test set</td>
  </tr>
  <tr>
    <td>Y_test</td>
    <td>2947 x 1</td>
    <td>Activity labels for the test set(1 to 6)</td>
  </tr>
  <tr>
    <td>subject_test</td>
    <td>2947 x 1</td>
    <td>Participant labels for the test set</td>
  </tr>

  <tr>
    <td>testDataTemp</td>
    <td>2947 x 562</td>
    <td>Activity + 561 features. For the test set.</td>
  </tr>
  <tr>
    <td>testDataFinal</td>
    <td>2947 x 563</td>
    <td>Subject + Activity + 561 features. For the test set.</td>
  </tr>
  <tr>
    <td>selectColumns</td>
    <td>81</td>
    <td>ndices of columns which measure mean and standard deviation</td>
  </tr>
  <tr>
    <td>mergedDataSet</td>
    <td>10299 x 81</td>
    <td>The final dataset where the testing and training sets are combined, and columns which measure mean and standard deviation are selected</td>
  </tr>
</table>













