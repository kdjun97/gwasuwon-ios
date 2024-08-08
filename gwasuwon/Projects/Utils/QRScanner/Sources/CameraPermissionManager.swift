//
//  CameraPermissionManager.swift
//  QRScanner
//
//  Created by 김동준 on 7/17/24
//

import AVFoundation

public class CameraPermissionManager: ObservableObject {
    @Published public var isCameraPermissionGranted = false

    public init(isCameraPermissionGranted: Bool = false) {
        self.isCameraPermissionGranted = isCameraPermissionGranted
    }

    public func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { accessGranted in
            DispatchQueue.main.async {
                self.isCameraPermissionGranted = accessGranted
            }
        })
    }
}
