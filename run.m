%Saman mohseni 9430713

%Reading watermark logo
W2D = imread('iut5.bmp');

%Binarizing logo
min_point = max(W2D( : ))/2;
W2D = (W2D > min_point);

%Reading cover image
I = imread('lena.bmp');

%Just to make sure that the input is single channel
try
    I = rgb2gray(I);
catch
    %Do nothing!
end


%Setting watermarking options
B = 8;
a = B/2;
K = 19;
alpha = 50;
Q = 40;

%Full test of all functions
main_project(I, B, a, W2D, K, alpha, Q);
