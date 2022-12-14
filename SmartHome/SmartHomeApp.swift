//
//  SmartHomeApp.swift
//  SmartHome
//
//  Created by Андрей Парчуков on 19.10.2022.
//

import SwiftUI

@main
struct SmartHomeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(HomeStore.shared)
        }
    }
}
