// The MIT License (MIT)
//
// Copyright (c) 2015 Rudolf Adamkovič
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software isı
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

extension UIImage {
    
    func imageByApplyingBlurWithRadius(radius: CGFloat, saturation: CGFloat = 1.8) -> UIImage {
        
        guard let CGImage = CGImage else {
            preconditionFailure()
        }
        
        let outputCGImage = CGImage.imageByApplyingBlurWithRadius(radius * scale, saturation: saturation)
        let outputUIImage = UIImage(CGImage: outputCGImage, scale: scale, orientation: .Up)
        
        return outputUIImage
        
    }
    
}

extension CGImage {
    
    func imageByApplyingBlurWithRadius(radius: CGFloat, saturation: CGFloat) -> CGImage {
        
        let blurParametrization = vImage_BlurParametrization(blurRadius: radius)
        
        var imageBuffer = vImageBlurCreateImageBuffer(self)
        var shadowBuffer = vImageBlurCreateShadowBuffer(&imageBuffer, blurParametrization)
        let temporaryBuffer = vImageBlurCreateTemporaryBuffer(&imageBuffer, blurParametrization)
        
        vImageBlur(&imageBuffer, &shadowBuffer, temporaryBuffer, blurParametrization)
        vImageSaturate(&imageBuffer, &shadowBuffer, saturation)
        
        let outputCGImage = vImageBlurCreateImage(&imageBuffer)
        
        free(imageBuffer.data)
        free(shadowBuffer.data)
        free(&temporaryBuffer.memory)
        
        return outputCGImage
        
    }
    
}
