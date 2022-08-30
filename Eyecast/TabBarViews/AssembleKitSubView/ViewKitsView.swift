//
//  ViewKitsView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 7/11/22.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct ViewKitsView: View {
    @State private var searchText = ""
    @State private var kitNames: Array<String> = Array()
    
    init() {
        
        UITableView.appearance().backgroundColor = UIColor(red: 0.957, green: 0.902, blue: 0.824, alpha: 0.0)
        
    }
    var ref = Database.database().reference()

    func getKitNames(){
        kitNames.removeAll()
       //Array to the serial numbers
        ref.child("Kits").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children{
               
               let snap = child as! DataSnapshot
               let key = snap.key
  

               
               kitNames.append("\(key)")
               
           }
            print(kitNames)
       }

   }
    
    var body: some View  {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { specficKitName in
                    NavigationLink(destination: ViewIndividualKitView(specficKitName: specficKitName, nameOfLocation: "Kendall", nameOfSubcontractor: "Eyecast", thePickupDate: "now", theCabinetNumber: "Cabinet 1111", theComment: "None") ) {
                        
                        Text(specficKitName)
                    }
                }
                .font(.system(size: 20))

            }
            .searchable(text: $searchText)
            .background(Color(red: 0.957, green: 0.906, blue: 0.824, opacity: 1.0))

//            .navigationTitle("View Kits").foregroundColor(Color.black)

        }
        .navigationBarTitle(Text("View Kits"), displayMode: .inline)
        .onAppear {
            getKitNames()
        }


    }
        
    
    var searchResults: [String] {
          if searchText.isEmpty {
              return kitNames
          } else {
              return kitNames.filter { $0.contains(searchText) }
          }
      }
}

struct ViewKitsView_Previews: PreviewProvider {
    static var previews: some View {
        ViewKitsView()
    }
}
