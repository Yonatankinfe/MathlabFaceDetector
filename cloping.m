% Specify the folder containing the original images
inputFolder = 'C:\Users\25197\OneDrive\Desktop\Friends\orginal_other';

% Specify the folder for saving the cropped images
outputFolder = 'C:\Users\25197\OneDrive\Desktop\Friends\Train\other';

% Create the output folder if it doesn't exist
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

% Create a face detector object
faceDetector = vision.CascadeObjectDetector();

% Get a list of all image files in the input folder
imageFiles = dir(fullfile(inputFolder, '*.jpg'));  % Update the extension if your images have a different format

% Loop through each image
for i = 1:length(imageFiles)
    % Read the original image
    originalImage = imread(fullfile(inputFolder, imageFiles(i).name));

    % Detect faces in the image
    bbox = step(faceDetector, originalImage);

    % Check if any faces are detected
    if ~isempty(bbox)
        % Crop the first detected face
        x = bbox(1, 1);
        y = bbox(1, 2);
        width = bbox(1, 3);
        height = bbox(1, 4);

        % Crop the image
        croppedImage = imcrop(originalImage, [x, y, width, height]);

        % Display the original and cropped images
        figure;
        subplot(1, 2, 1);
        imshow(originalImage);
        title(['Original Image - ' imageFiles(i).name]);

        subplot(1, 2, 2);
        imshow(croppedImage);
        title(['Cropped Image - ' imageFiles(i).name]);

        % Specify the file path for saving the cropped image
        [~, imageName, imageExt] = fileparts(imageFiles(i).name);
        savePath = fullfile(outputFolder, [imageName '_cropped' imageExt]);

        % Save the cropped image
        imwrite(croppedImage, savePath);

        disp(['Cropped image with detected face saved at: ' savePath]);
    else
        disp(['No faces detected in image: ' imageFiles(i).name]);
    end

    % Close figures to avoid cluttering the display
    close all;
end

