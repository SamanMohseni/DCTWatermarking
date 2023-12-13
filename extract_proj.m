%Saman mohseni 9430713

function S = extract_proj(W_image, B, a, K)

%Number of blocks in each colomn and each row
[h, w] = size(W_image);
h = floor(h/B);
w = floor(w/B);

S_encrypt = uint8(zeros(h*w, 1));

watermark_index = 1;
for i = 1:h
    for j = 1:w
        
        %Calculating block bounds
        i_begin = (i - 1)*B + 1;
        i_end = i*B;
        j_begin = (j - 1)*B + 1;
        j_end = j*B;
        
        %Extracting and converting block
        watermarked_block = W_image(i_begin : i_end, j_begin : j_end);
        watermarked_block_dct = dct2(watermarked_block);
        
        %Extracting corresponding watermark bit
        if(watermarked_block_dct(a+1, a) > watermarked_block_dct(a, a+1))
            S_encrypt(watermark_index) = 1;
        else
            S_encrypt(watermark_index) = 0;
        end
        
        watermark_index = watermark_index + 1;
    end
end

%Decrypting the watermark
rand('seed', K);
L = randperm(h*w);
S = uint8(zeros(size(S_encrypt)));
for i = 1 : size(S_encrypt)
    S(L(i)) = S_encrypt(i);
end

