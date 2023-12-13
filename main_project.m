%Saman mohseni 9430713

function main_project(I, B, a, W2D, K, alpha, Q)

%Showing original image
figure,imshow(I); title('Original image');

%Showing original watermark logo
%Resized to match the size of extracted logo
logo_resized = imresize(W2D, floor(size(I)/B));
figure,imshow(logo_resized); title('Original logo, just resized');

%Watermarking, PSNR will be printed within this function
[W_image, W1D]= embed_proj(I, B, a, W2D, K ,alpha);

%Showing watermarked image
figure,imshow(W_image); title('Watermarked image');

%Attacking to watermarked image
imwrite(W_image, 'attacked.jpg', 'quality', Q);
W_image = imread('attacked.jpg');

%Showing watermarked image after attack
figure,imshow(W_image); title('attacked Watermarked image');

%Extracting watermark logo from attacked image
S = extract_proj(W_image, B, a, K);

%Reshaping and showing extracted watermark logo from attacked image
extracted_logo = reshape(S, size(logo_resized));
figure,imshow(extracted_logo*255); title('Extracted logo');

%Showing NC of extracted logo with respect to the original one
NC = NC_project(S, W1D);
fprintf('NC : %f\n', NC);
