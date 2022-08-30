//
//  BuiltCabinetViewI.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/29/22.
//

import SwiftUI
import FirebaseDatabase
import Firebase

struct BuiltCabinetViewI: View {
    @State private var cabinetSerialNumbers: Array<String> = Array()
    @State private var showingAlert = false
    @State private var alertString = ""

   //Function in testing
   func getCabinetSerialNumber(){
       cabinetSerialNumbers.removeAll()
      //Array to the serial numbers
      ref.child("Tested Cabinets").observeSingleEvent(of: .value) { (snapshot) in
          for child in snapshot.children{
              
              let snap = child as! DataSnapshot
              let key = snap.key
 

              
              cabinetSerialNumbers.append("\(key)")
              
          }
           print(cabinetSerialNumbers)
      }

  }
    var ref = Database.database().reference()

    init() {
        
        UITableView.appearance().backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 0.0)
        
    }
    

    
    
    
    var body: some View {
        
        
    
        

            VStack {

                Text("Tested Cabinets")
                    .foregroundColor(.black)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding(.top, (UIScreen.main.bounds.height * 0.05))
                    .padding(.leading, -(UIScreen.main.bounds.width * 0.38))
                List {
                    
                    Section(header: Text("long press number to delete")) {
                        
                        ForEach(0..<cabinetSerialNumbers.count, id: \.self) { index in
                            
                            Text("\(self.cabinetSerialNumbers[index])")
                               
                                .onTapGesture {}.onLongPressGesture(minimumDuration: 0.2) {
                                    print("long press \(index)")
                                    print("long press \(cabinetSerialNumbers[index])")
                                    alertString = cabinetSerialNumbers[index]

                                      showingAlert=true
                                        }.alert("Are you sure you want to delete cabinet 🗄\(alertString)", isPresented: $showingAlert, actions: {
                                            Button("Delete", role: .destructive, action: {
                                                
                                                ref.child("Tested Cabinets").child(alertString).removeValue()
                                                print("i am going to delete you")
                                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                                    
                                                    
                                                    getCabinetSerialNumber()
                                                }

                                            })
                                        }, message: {
                                            Text("")
                                        })
                            
                        }

                    }

                    

                }.listStyle(.grouped)


                
                .onAppear(){
                    getCabinetSerialNumber()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                        
                    
                        print("this is the array onAppear \(self.cabinetSerialNumbers)")
                        
                    }
                    
                }
                
                .cornerRadius(20)
            }

        
        
    }
}

struct BuiltCabinetViewI_Previews: PreviewProvider {
    static var previews: some View {
        BuiltCabinetViewI()
    }
}
