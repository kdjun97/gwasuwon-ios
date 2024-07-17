//
//  GQRScanner.swift
//  QRScanner
//
//  Created by 김동준 on 7/16/24
//

import UIKit
import SwiftUI
import Foundation

public struct GQRScanner: UIViewControllerRepresentable {
    @Binding var result: String

    public init(result: Binding<String>) {
        _result = result
    }

    public func makeUIViewController(context: Context) -> GQRScannerController {
        let controller = GQRScannerController()
        controller.delegate = context.coordinator

        return controller
    }

    public func updateUIViewController(_ uiViewController: GQRScannerController, context: Context) {
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator($result)
    }
}
