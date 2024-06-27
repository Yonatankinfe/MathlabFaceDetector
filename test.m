% Load the pre-trained Yonatan model
load('model.mat', 'modelNet');

% Prompt the user to select an image file
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp', 'Image files (*.jpg, *.png, *.bmp)'}, 'Select an image file');

% Check if the user selected a file
if isequal(filename, 0) || isequal(pathname, 0)
    disp('User canceled the operation. Exiting...');
    return;
end

% Construct the full path to the selected image
fullImagePath = fullfile(pathname, filename);

% Read the selected image
img = imread(fullImagePath);

% Detect faces in the image
faceDetector = vision.CascadeObjectDetector();
bbox = step(faceDetector, img);

% Check if any faces are detected
if ~isempty(bbox)
    % Initialize cell array to store predicted labels for each face
    predictedLabels = cell(size(bbox, 1), 1);

    % Create a single figure for displaying all faces
    figure;
    imshow(img);
    hold on;

    % Process each detected face
    for i = 1:size(bbox, 1)
        % Crop and resize the detected face
        face = imresize(imcrop(img, bbox(i, :)), [224, 224]);

        % Classify the face using the trained model
        predictedLabels{i} = char(classify(modelNet, face));

        % Draw the bounding box around the detected face
        rectangle('Position', bbox(i, :), 'EdgeColor', 'r', 'LineWidth', 2);

        % Display the classification result for each face
        text(bbox(i, 1), bbox(i, 2) - 10, ['Face ', num2str(i), ': ', predictedLabels{i}], 'Color', 'g', 'FontSize', 20);
    end

    hold off;

    % Optionally, display a summary of all detected faces and their labels
    disp('Summary of Detected Faces:');
    for i = 1:length(predictedLabels)
        disp(['Face ', num2str(i), ': ', predictedLabels{i}]);
    end
else
    % If no faces are detected, display a message
    disp('No face detected in the selected image.');
end

