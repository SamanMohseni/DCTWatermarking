# Robust Image Watermarking with DCT Manipulation

This project presents a robust method for embedding watermarks into images by manipulating the Discrete Cosine Transform (DCT) coefficients of image blocks. The process involves resizing the watermark, reshaping it into a one-dimensional array, encrypting it with a key, and then carefully embedding it into the DCT coefficients of the cover image. The method ensures that watermarked images can withstand common attacks such as JPEG compression while maintaining the ability to accurately extract the watermark.

## Watermarking Process Overview

- **Resize Watermark**: The watermark is resized to match the dimensions of the image blocks of the cover image.
- **Watermark Encryption**: The watermark is encrypted using a permutation based on a key to enhance security and make it harder to detect.
- **DCT Manipulation**: The encrypted watermark is embedded into the DCT coefficients of the image blocks. The method involves ensuring an inequality between two selected DCT coefficients that correspond to the watermark bit.
- **Inverse DCT**: After embedding the watermark, the inverse DCT is applied to generate the watermarked image blocks, which are then assembled to form the final watermarked image.

## Results

Robustness is evaluated by assessing the watermarked images' resistance to JPEG compression attacks. The success of the watermark extraction is quantified using the Normalized Correlation (NC) metric. The tables below showcase the NC values obtained under different conditions, illustrating the effectiveness of the watermarking process across various JPEG quality settings and alpha values.

### Table 1: Results for Lena.bmp with B = 8, a = B/2, K = 19

| JPEG Quality | NC (Alpha = 0) | NC (Alpha = 10) | NC (Alpha = 50) | NC (Alpha = 100) |
|--------------|----------------|-----------------|-----------------|------------------|
| 100          | 0.879783       | 1.000000        | 1.000000        | 1.000000         |
| 80           | 0.539222       | 0.690051        | 1.000000        | 1.000000         |
| 60           | 0.489477       | 0.496173        | 1.000000        | 1.000000         |
| 40           | 0.467793       | 0.472895        | 0.890944        | 1.000000         |

_Pre-attack PSNR: 27.487390 (Alpha = 0), 23.904089 (Alpha = 10), 17.971996 (Alpha = 50), 15.505975 (Alpha = 100)_

### Table 2: Results for Lena.bmp with B = 8, a = B/2 + 1, K = 19

| JPEG Quality | NC (Alpha = 0) | NC (Alpha = 10) | NC (Alpha = 50) | NC (Alpha = 100) |
|--------------|----------------|-----------------|-----------------|------------------|
| 100          | 0.857781       | 1.000000        | 1.000000        | 1.000000         |
| 80           | 0.496811       | 0.504145        | 1.000000        | 1.000000         |
| 60           | 0.478316       | 0.481505        | 0.727041        | 1.000000         |
| 40           | 0.460459       | 0.463648        | 0.465561        | 1.000000         |

_Pre-attack PSNR: 28.631670 (Alpha = 0), 24.155811 (Alpha = 10), 17.979725 (Alpha = 50), 15.499243 (Alpha = 100)_

### Table 3: Results for Lena.bmp with B = 10, a = B/2, K = 19

| JPEG Quality | NC (Alpha = 0) | NC (Alpha = 10) | NC (Alpha = 50) | NC (Alpha = 100) |
|--------------|----------------|-----------------|-----------------|------------------|
| 100          | 0.821235       | 1.000000        | 1.000000        | 1.000000         |
| 80           | 0.561481       | 0.839012        | 1.000000        | 1.000000         |
| 60           | 0.531358       | 0.614815        | 0.998025        | 1.000000         |
| 40           | 0.510617       | 0.563951        | 0.836049        | 1.000000         |

_Pre-attack PSNR: 28.330018 (Alpha = 0), 24.764104 (Alpha = 10), 18.919924 (Alpha = 50), 16.073579 (Alpha = 100)_

### Table 4: Results for Lena.bmp with B = 10, a = B/2 + 1, K = 19

| JPEG Quality | NC (Alpha = 0) | NC (Alpha = 10) | NC (Alpha = 50) | NC (Alpha = 100) |
|--------------|----------------|-----------------|-----------------|------------------|
| 100          | 0.791111       | 1.000000        | 1.000000        | 1.000000         |
| 80           | 0.545185       | 0.709630        | 1.000000        | 1.000000         |
| 60           | 0.519012       | 0.575309        | 0.892840        | 1.000000         |
| 40           | 0.511111       | 0.548642        | 0.669630        | 0.970370         |

_Pre-attack PSNR: 29.431531 (Alpha = 0), 25.072157 (Alpha = 10), 18.925194 (Alpha = 50), 16.097546 (Alpha = 100)_

### Table 5: Results for Lena.bmp with B = 12, a = B/2, K = 19

| JPEG Quality | NC (Alpha = 0) | NC (Alpha = 10) | NC (Alpha = 50) | NC (Alpha = 100) |
|--------------|----------------|-----------------|-----------------|------------------|
| 100          | 0.788167       | 1.000000        | 1.000000        | 1.000000         |
| 80           | 0.573411       | 0.849525        | 1.000000        | 1.000000         |
| 60           | 0.538349       | 0.638422        | 0.998539        | 1.000000         |
| 40           | 0.528123       | 0.563185        | 0.813002        | 1.000000         |

_Pre-attack PSNR: 29.234143 (Alpha = 0), 25.620711 (Alpha = 10), 19.759244 (Alpha = 50), 16.834533 (Alpha = 100)_

### Table 6: Results for Lena.bmp with B = 12, a = B/2 + 1, K = 19

| JPEG Quality | NC (Alpha = 0) | NC (Alpha = 10) | NC (Alpha = 50) | NC (Alpha = 100) |
|--------------|----------------|-----------------|-----------------|------------------|
| 100          | 0.781592       | 1.000000        | 1.000000        | 1.000000         |
| 80           | 0.532505       | 0.696129        | 1.000000        | 1.000000         |
| 60           | 0.507670       | 0.564646        | 0.878744        | 1.000000         |
| 40           | 0.492330       | 0.528853        | 0.641344        | 0.936450         |

_Pre-attack PSNR: 30.067253 (Alpha = 0), 25.866052 (Alpha = 10), 19.784238 (Alpha = 50), 16.841002 (Alpha = 100)_

## Adaptive Alpha

The adaptive alpha implementation adjusts the watermark embedding strength based on the variance of each image block. By analyzing the block's content, a suitable alpha value is applied to maintain the watermark's robustness without compromising the visual quality of the cover image.

### Adaptive Alpha Approach

- Estimate the variance of each block.
- Adjust the alpha value proportionally to the variance, ensuring that blocks with higher variance (more detail) can withstand stronger watermarking without visible artifacts.
- Apply the adjusted alpha value during the DCT coefficient manipulation.

Here's an illustration comparing the two methods:

Non-Adaptive             |  Adaptive
:-------------------------:|:-------------------------:
![Adaptive](https://github.com/SamanMohseni/DCTWatermarking/assets/51726090/7f50ac2f-18ae-4285-b9d7-9eafc848f0b7)  |  ![Non-Adaptive](https://github.com/SamanMohseni/DCTWatermarking/assets/51726090/e0d10646-71ec-41c4-a8ff-08a1ca792fe4)


## Conclusion

The presented tables demonstrate the watermark's robustness across different settings and JPEG compression levels. The adaptive alpha method further refines the watermarking process, providing an additional layer of robustness by adapting the embedding strength to the image content.
