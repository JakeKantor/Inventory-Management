//
//  CameraPartsView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/27/22.
//

import SwiftUI

struct InventoryTableView: View {
    
    init() {
        UITableView.appearance().separatorColor = .black
        UITableView.appearance().separatorStyle = .singleLine
        UITableViewCell.appearance().contentView.layer.cornerRadius = 20
        UITableView.appearance().backgroundColor = .clear

    }
    var body: some View {
        List() {
            Group{
                Text("Built Cameras")
                Text("Built Cabinets")
                Text("Camera Parts")
                Text("Cabinet Part")
                Text("Camera Mounting")
                Text("Cabinet Mounting")
                Text("Tools")
                    
            }
            .listRowBackground(Color.clear)
            .font(.system(size: 30, weight: .semibold, design: .rounded))
            .padding(.bottom, UIScreen.main.bounds.height * 0.03).padding(.top, UIScreen.main.bounds.height * 0.03).listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))


        }
        .listStyle(PlainListStyle())


        
    }
}

struct InventoryTableView_Preview: PreviewProvider {
    static var previews: some View {
        InventoryTableView()
    }
}
