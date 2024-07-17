//
//  GQRCodeGenerator.swift
//  QRScanner
//
//  Created by 김동준 on 7/15/24
//

import CoreImage.CIFilterBuiltins
import UIKit
import SwiftUI

public struct GQRCodeGenerator: View {
    let qrData: String
    let width: CGFloat
    let height: CGFloat
    
    public init(qrData: String, width: CGFloat, height: CGFloat) {
        self.qrData = qrData
        self.width = width
        self.height = height
    }
    
    public var body: some View {
        Image(uiImage: generateQRCode(qrData: qrData))
            .resizable().scaledToFit().frame(width: width, height: height)
    }
    
    private func generateQRCode(qrData: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()

        filter.setValue(qrData.data(using: .utf8), forKey: "inputMessage")

        if let qrCodeImage = filter.outputImage {
            let transform = CGAffineTransform(scaleX: 5, y: 5)
            let scaledCIImage = qrCodeImage.transformed(by: transform)
            if let qrCodeCGImage = context.createCGImage(scaledCIImage, from: scaledCIImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        
        return UIImage()
    }
}
