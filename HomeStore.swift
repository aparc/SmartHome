//
//  HomeStore.swift
//  SmartHome
//
//  Created by Андрей Парчуков on 30.10.2022.
//

import Foundation
import HomeKit
import SwiftUI

class HomeStore: NSObject, ObservableObject {
    
    static let shared: HomeStore = .init()
    
    @Published var accessoryList: [String] = .init()
    @Published var roomsGridViewModel: [RoomCellViewModel] = .init()
    
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
    
    func addNewRoom() {
        homeManager.primaryHome?.addRoom(withName: "Комната") { room, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let room = room {
                let viewModel = RoomCellViewModel(room: Room(name: room.name, devicesCount: room.accessories.count))
                self.roomsGridViewModel.append(viewModel)
            }
        }
    }
   
}

// MARK: - HMHomeManagerDelegate
extension HomeStore: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        guard let primaryHome = manager.primaryHome else { return }
        accessoryList = primaryHome.accessories.map { $0.name }
        roomsGridViewModel = primaryHome.rooms.map { room in
            RoomCellViewModel(room: Room(name: room.name, devicesCount: room.accessories.count))
        }
    }
}
