% Load the trained model
load('model.mat', 'modelNet');

% Define the path to your test data
testDataPath = 'C:\Users\25197\OneDrive\Desktop\Friends\Test';

% Create imageDatastore for test data
testDatastore = imageDatastore(testDataPath, ...
    'IncludeSubfolders', true, 'LabelSource', 'foldernames');

% Resize images to match the expected input size of the CNN
inputSize = [224, 224];
augmentedTestData = augmentedImageDatastore(inputSize, testDatastore, 'ColorPreprocessing', 'gray2rgb');

% Make predictions on the test data using the trained model
predictions = classify(modelNet, augmentedTestData);

% Convert the categorical predictions and actual labels to numeric values
predictedLabels = grp2idx(predictions);
actualLabels = grp2idx(testDatastore.Labels);

% Create a confusion matrix
confMat = confusionmat(actualLabels, predictedLabels);

% Normalize the confusion matrix
confMatNormalized = confMat ./ sum(confMat, 2);

% Display the confusion matrix as a heatmap with the default colormap
figure;
heatmap(confMatNormalized, 'ColorbarVisible', 'on', ...
    'XLabel', 'Predicted Labels', 'YLabel', 'Actual Labels', ...
    'Title', 'Confusion Matrix');

% Display the accuracy in the title
accuracy = sum(diag(confMat)) / sum(confMat(:));
title(['Confusion Matrix | Accuracy: ' num2str(accuracy * 100) '%']);


