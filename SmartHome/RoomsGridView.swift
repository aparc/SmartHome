//
//  RoomsGridView.swift
//  SmartHome
//
//  Created by Андрей Парчуков on 31.10.2022.
//

import SwiftUI

struct Room {
    var name: String
    var devicesCount: Int
}

final class RoomCellViewModel {
    
    var name: String {
        room.name
    }
    
    var devicesCount: Int {
        room.devicesCount
    }
    
    private let room: Room
    
    init(room: Room) {
        self.room = room
    }
    
}

struct RoomsGridView: View {
    
    var items: [RoomCellViewModel]

    private let spacing = 20.0
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 20.0), count: 2)
    
    var body: some View {
        GeometryReader { geo in
//            ScrollView {
                VStack(alignment: .leading) {
                    Text("Rooms")
                        .bold()
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(items, id: \.name) { viewModel in
                            RoomCell(viewModel: viewModel)
                                .frame(height: (geo.size.width - spacing) / 2.0)
                        }
                    }
                }
//            }
        }
    } // body
}

struct RoomCell: View {
    
    var viewModel: RoomCellViewModel
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.blue.opacity(0.4))
            VStack {
                Text(viewModel.name)
                    .bold()
                if viewModel.devicesCount > 0 {
                    Text("\(viewModel.devicesCount) device")
                }
            }
            .padding(10)
        }
    }
    
}

struct RoomsGridView_Previews: PreviewProvider {
    static var previews: some View {
        let roomCellViewModel = RoomCellViewModel(room: Room(name: "Bedroom", devicesCount: 2))
        RoomsGridView(items: [roomCellViewModel])
            .padding()
    }
}
