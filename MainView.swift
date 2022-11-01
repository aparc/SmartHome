//
//  MainView.swift
//  SmartHome
//
//  Created by Андрей Парчуков on 30.10.2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var homeStore: HomeStore
    
    @State private var newRoomSheetPresented: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(homeStore.accessoryList, id: \.self) { accessory in
                    Text("\(accessory)")
                }
                .listStyle(.plain)
                
                RoomsGridView(items: homeStore.roomsGridViewModel)
                    .padding()
            }
            .navigationTitle("Home")
            .toolbar {
                addingMenu
            }
            .sheet(isPresented: $newRoomSheetPresented) {
                
            }
        }
    }
    
    var addingMenu: some View {
        Menu {
            Button(action: homeStore.addAccessory) {
                Text("Add accessory")
            }
            Button(action: {newRoomSheetPresented.toggle()}) {
                Text("Add new room")
            }
        } label: {
            Image(systemName: "plus")
        }
    }
    
}

struct NewRoomAddingView: View {
    var body: some View {
        NavigationView {
            Section {
                
            }
            .navigationTitle("New Room")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
            
            }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
