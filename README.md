# Custom Face Detector Using AI in MATLAB

## Introduction
**Welcome to the Custom Face Detector project!** This repository contains code and resources for building a custom face detection system using MATLAB. By leveraging Convolutional Neural Networks (CNNs), this project aims to accurately detect and classify faces from a set of images. Whether you are a beginner or an advanced user, this project provides a practical example of how to implement machine learning for image processing tasks.

## Project Overview
This project demonstrates how to create a custom face detector using a Convolutional Neural Network (CNN) in MATLAB. The steps include preparing the dataset, training the model, detecting faces in new images, and evaluating the model's performance. Here’s a brief overview of what the code does:

### Data Preparation
- **Load images of two individuals (Yonatan and another person) from specified folders.**
- Combine the images into a single datastore.
- Split the data into training and validation sets.

### Data Augmentation
- Resize the images to match the input size expected by the CNN.
- Convert grayscale images to RGB format.

### CNN Architecture
- Define a simple CNN with several convolutional, batch normalization, ReLU, and max-pooling layers.
- Add fully connected, softmax, and classification layers for the final output.

### Training
- Set training options such as the optimizer, learning rate, and number of epochs.
- Train the CNN using the augmented training data.
- Save the trained model.

### Face Detection
- Use a pre-trained model to detect faces in new images.
- Crop and resize the detected faces.
- Classify the faces using the trained CNN.

### Evaluation
- Load test data and make predictions using the trained model.
- Display a confusion matrix to visualize the performance.
- Calculate and display the accuracy of the model.

This project provides a comprehensive example of using MATLAB for image classification and face detection tasks, leveraging the power of convolutional neural networks and data augmentation techniques.
