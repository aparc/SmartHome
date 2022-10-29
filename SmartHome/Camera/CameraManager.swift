//
//  CameraManager.swift
//  SmartHome
//
//  Created by Андрей Парчуков on 28.10.2022.
//

import AVFoundation

final class CameraManager: ObservableObject {
    
    static let shared: CameraManager = .init()
    
    private let session: AVCaptureSession = .init()
    private let sessionQueue: DispatchQueue = .init(label: "com.aparc.SessionQ")
    private let videoOutput: AVCaptureVideoDataOutput = .init()
    private let metadataOutput: AVCaptureMetadataOutput = .init()
    
    private init() {}
    
    func set(
      _ delegate: AVCaptureVideoDataOutputSampleBufferDelegate,
      queue: DispatchQueue
    ) {
      sessionQueue.async {
        self.videoOutput.setSampleBufferDelegate(delegate, queue: queue)
      }
    }
    
    func setAVCaptureMetadataOutputObjectsDelegate(
        _ delegate: AVCaptureMetadataOutputObjectsDelegate,
        queue: DispatchQueue
    ) {
        sessionQueue.async {
            self.metadataOutput.setMetadataObjectsDelegate(delegate, queue: queue)
        }
    }
    
    func configure() {
        checkPermissions()
        sessionQueue.async {
            self.configureCaptureSession()
            self.session.startRunning()
        }
    }
    
    private func configureCaptureSession() {
        session.beginConfiguration()
        defer {
            session.commitConfiguration()
        }
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input) {
                session.addInput(input)
            }
        } catch {
            print(error.localizedDescription)
            return
        }
        
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
            let connection = videoOutput.connection(with: .video)
            connection?.videoOrientation = .portrait
        }
        
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
            metadataOutput.metadataObjectTypes = [.qr]
        }
        
    }
    
    private func checkPermissions() {
        sessionQueue.suspend()
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { authorized in
                
            }
        default: break
        }
        self.sessionQueue.resume()
    }
    
}
