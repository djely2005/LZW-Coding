% Test with string
input_string = "TOBEORNOTTOBEORTOBEORNOT";
encoded_string = LzwEncod16(input_string);
decoded_string = LzwDecod(encoded_string);
disp("Original string: " + input_string);
disp("Decoded string:  " + decoded_string);

% Test with image
image = imread("coins.png");
image_subset = image(1:75, 1:75);  % Extract 75x75 portion

% Encode the image (convert to vector first)
encoded_image = LzwEncod16(image_subset(:));

% Decode the image
decoded_image = LzwDecod(encoded_image);

% Reshape back to original dimensions and convert to uint8
reconstructedImg = reshape(uint8(decoded_image), [75, 75]);

% Display the original and reconstructed images
figure;
subplot(1,2,1); imshow(image_subset); title('Original Image');
subplot(1,2,2); imshow(reconstructedImg); title('Reconstructed Image');