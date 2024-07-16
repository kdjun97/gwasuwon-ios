//
//  GQRScannerController.swift
//  QRScanner
//
//  Created by 김동준 on 7/16/24
//

import UIKit
import AVFoundation
import SwiftUI

public final class QRScannerController: UIViewController {
    var captureSession = AVCaptureSession()
    var captureDevice: AVCaptureDevice?
    var delegate: AVCaptureMetadataOutputObjectsDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        cameraDefaultSetting()
    }
    
    private func cameraDefaultSetting() {
        captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        
        guard let captureDevice = captureDevice else {
            return
        }

        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            return
        }

        captureSession.addInput(videoInput)

        let captureMetadataOutput = AVCaptureMetadataOutput()
        
        captureSession.addOutput(captureMetadataOutput)

        captureMetadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [.qr]
        
        setVideoPreviewLayer()
        
        // Start video capture.
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    private func setVideoPreviewLayer() {
        var videoPreviewLayer: AVCaptureVideoPreviewLayer
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        videoPreviewLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        view.layer.addSublayer(videoPreviewLayer)
    }
}

public class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    @Binding var scanResult: String

    init(_ scanResult: Binding<String>) {
        _scanResult = scanResult
    }

    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            scanResult = "No QR code detected"
            return
        }

        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if metadataObj.type == AVMetadataObject.ObjectType.qr,
           let result = metadataObj.stringValue {
            scanResult = result
        }
    }
}
