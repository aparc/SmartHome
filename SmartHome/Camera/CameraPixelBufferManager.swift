//
//  CameraPixelBufferManager.swift
//  SmartHome
//
//  Created by Андрей Парчуков on 29.10.2022.
//

import AVFoundation
import HomeKit

final class CameraPixelBufferManager: NSObject, ObservableObject {
    
    static let shared = CameraPixelBufferManager()
      
      @Published var buffer: CVPixelBuffer?
      
      let videoOutputQueue = DispatchQueue(
        label: "com.aparc.VideoOutputQ",
        qos: .userInitiated,
        attributes: [],
        autoreleaseFrequency: .workItem)
      
      private override init() {
        super.init()
        CameraManager.shared.set(self, queue: videoOutputQueue)
          CameraManager.shared.setAVCaptureMetadataOutputObjectsDelegate(self, queue: videoOutputQueue)
      }
    
}

extension CameraPixelBufferManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
      ) {
        if let buffer = sampleBuffer.imageBuffer {
          DispatchQueue.main.async {
            self.buffer = buffer
          }
        }
      }
    
}

extension CameraPixelBufferManager: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else { return }
        guard let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject else { return }
       
        
        print(object.bounds.midX, object.bounds.midY)
    }
}
