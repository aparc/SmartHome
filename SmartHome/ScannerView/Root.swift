//
//  Root.swift
//  SmartHome
//
//  Created by Андрей Парчуков on 29.10.2022.
//

import SwiftUI

struct Root: View {
    
    @StateObject private var videoOutputModel: VideoOutputModel = .init()
    
    var body: some View {
        if let image = videoOutputModel.cgImage {
            GeometryReader { geometry in
                
                Image(decorative: image, scale: 1.0, orientation: .up)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        alignment: .center)
                    .clipped()
            }
        } else {
            Button("Start") {
                videoOutputModel.startCamera()
            }
        }
    }
}

struct Root_Previews: PreviewProvider {
    static var previews: some View {
        Root()
    }
}
