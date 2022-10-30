//
//  MainView.swift
//  SmartHome
//
//  Created by Андрей Парчуков on 30.10.2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var homeStore: HomeStore
    
    var body: some View {
        NavigationView {
            VStack {
                List(homeStore.accessoryList, id: \.self) { accessory in
                    Text("\(accessory)")
                }
            }
            .navigationTitle(Text("Home"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: homeStore.addAccessory) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
