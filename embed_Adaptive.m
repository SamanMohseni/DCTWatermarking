%Saman mohseni 9430713

function [W_image, W1D]= embed_Adaptive(I, B, a, W2D, K ,alpha)

%Resizing the watermark
W2D = imresize(W2D, floor(size(I)/B));

%Reshaping the watermark
W1D = W2D( : );

%Encrypting the watermark
rand('seed', K);
s = size(W1D);
L = randperm(s(1, 1));
W1D_encrypt = uint8(zeros(size(W1D)));
for i = 1 : size(W1D)
    W1D_encrypt(i) = W1D(L(i));
end

%Number of blocks in each column and each row
[h, w] = size(I);
h = floor(h/B);
w = floor(w/B);

%Watermarking the image
W_image = I;
watermark_index = 1;
for i = 1:h
    for j = 1:w
        
        %Calculating block bounds
        i_begin = (i - 1)*B + 1;
        i_end = i*B;
        j_begin = (j - 1)*B + 1;
        j_end = j*B;
        
        %Extracting and converting block
        original_block = I(i_begin : i_end, j_begin : j_end);
        original_block_dct = dct2(original_block);
        
        %Estimating block's disarray
        variance = original_block - mean(original_block(:));
        variance = variance .* variance;
        variance = mean(variance(:))/64;
        
        %Embedding corresponding watermark bit, 
        %into dct of watermarked block
        wtrmrked_blk_dct = original_block_dct;
        
        %Checking what bit the block initially corresponds to
        native_bit = wtrmrked_blk_dct(a+1, a) > wtrmrked_blk_dct(a, a+1);
        
        %What we acctually want the block to correspond to
        desired_bit = W1D_encrypt(watermark_index);
        
        %Checking whether the original order correspond to 
        %the desired bit or not, if not, we need to swap them
        swap_needed = (native_bit ~= desired_bit);
        
        Max = max(original_block_dct(a, a+1), original_block_dct(a+1, a));
        Min = min(original_block_dct(a, a+1), original_block_dct(a+1, a));
        difference = Max - Min;
        
        %The coefficient is resulted experimentally, 
        %considering that alpha ranges from 0 to 100
        desired_difference = (1 + alpha*variance) * 1.27;
        
        if(desired_difference > difference)
            offset = (desired_difference - difference) / 2;
        elseif(swap_needed)
            offset = (desired_difference - difference) / 2;
        else
            offset = 0;
        end
   
        if(W1D_encrypt(watermark_index) == 0)
            wtrmrked_blk_dct(a, a+1) = Max + offset;
            wtrmrked_blk_dct(a+1, a) = Min - offset;
        else
            wtrmrked_blk_dct(a, a+1) = Min - offset;
            wtrmrked_blk_dct(a+1, a) = Max + offset;
        end
        
        watermark_index = watermark_index + 1;
        
        %Converting and putting back to output image
        watermarked_block = idct2(wtrmrked_blk_dct);
        watermarked_block = uint8(watermarked_block);
        W_image(i_begin : i_end, j_begin : j_end) = watermarked_block;
    end
end

%Calculating PSNR
MSE = mean((I( : ) - W_image( : )) .^ 2);
PSNR = 10*log10(255 / sqrt(MSE));
fprintf('PSNR : %f\n', PSNR);
