//
//  GQRScanner.swift
//  QRScanner
//
//  Created by 김동준 on 7/16/24
//

import UIKit
import SwiftUI
import Foundation

public struct QRScanner: UIViewControllerRepresentable {
    @Binding var result: String
    private var isFullScreen: Bool

    public init(
        result: Binding<String>,
        isFullScreen: Bool = false
    ) {
        _result = result
        self.isFullScreen = isFullScreen
    }

    public func makeUIViewController(context: Context) -> QRScannerController {
        let controller = QRScannerController()
        controller.delegate = context.coordinator

        return controller
    }

    public func updateUIViewController(_ uiViewController: QRScannerController, context: Context) {
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator($result)
    }
}
