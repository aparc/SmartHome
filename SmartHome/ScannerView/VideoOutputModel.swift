//
//  VideOutputModel.swift
//  SmartHome
//
//  Created by Андрей Парчуков on 29.10.2022.
//

import CoreImage
import UIKit

class VideoOutputModel: ObservableObject {
    
    @Published var cgImage: CGImage?
    
    private let pixelBufferManager = CameraPixelBufferManager.shared
    
    init() {
        binding()
    }
    
    func startCamera() {
        CameraManager.shared.configure()
    }
    
    private func binding() {
        pixelBufferManager.$buffer
            .compactMap { $0 }
            .compactMap { buffer in
                CGImage.createImage(from: buffer)
            }
            .assign(to: &$cgImage)
    }
    
}

fileprivate let context = CIContext()

extension CGImage {
    
    
    
    static func createImage(from buffer: CVPixelBuffer) -> CGImage? {
        
        let ciImage = CIImage(cvPixelBuffer: buffer)
        let image = context.createCGImage(ciImage, from: ciImage.extent)
        
        return image
    }
    
}
