//
//  Root.swift
//  SmartHome
//
//  Created by Андрей Парчуков on 30.10.2022.
//

import SwiftUI

struct Root: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Home", systemImage: "home.fill")
                }
            AccessoryListView()
                .tabItem {
                    Label("Devices", systemImage: "homepod.and.homepodmini.fill")
                }
        }
    }
}

struct Root_Previews: PreviewProvider {
    static var previews: some View {
        Root()
    }
}
