//
//  HomeStore.swift
//  SmartHome
//
//  Created by Андрей Парчуков on 30.10.2022.
//

import Foundation
import HomeKit
import SwiftUI

class HomeStore: NSObject, ObservableObject, HMHomeManagerDelegate {
    
    static let shared: HomeStore = .init()
    
    @Published var accessoryList: [String] = .init()
    
    private let homeManager: HMHomeManager = .init()
        
    
    private override init() {
        super.init()
        homeManager.delegate = self
    }
    
    func addAccessory() {
        
        let accessorySetupManager = HMAccessorySetupManager()
        
        
        let setupRequest = HMAccessorySetupRequest()

        accessorySetupManager.performAccessorySetup(using: setupRequest) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let _ = result {
                print("accessory added")
            }
        }
    }
    
    func refresh() {
        guard let home = homeManager.primaryHome else { return }
        accessoryList = home.accessories.map { $0.name }
    }
    
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        guard let primaryHome = manager.primaryHome else { return }
        accessoryList = primaryHome.accessories.map { $0.name }
    }
    
    
}
