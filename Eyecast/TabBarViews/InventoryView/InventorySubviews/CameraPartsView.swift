//
//  CameraPartsView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/29/22.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseAuth
struct CameraPartsView: View {
    
    var ref = Database.database().reference()

    init() {
        
        UITableView.appearance().backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 0.0)
        
    }
    

    
    
    @State var lenseSizes = [PartandMounting(partName: "2 mm Lense",partType: "Camera Parts", quantityLeft: 0),PartandMounting(partName: "4 mm Lense",partType: "Camera Parts", quantityLeft: 0)]
    
    var body: some View {
        
        
    
        

            VStack {
                
                Text("Camera Parts")
                    .foregroundColor(.black)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding(.top, (UIScreen.main.bounds.height * 0.05))
                    .padding(.leading, -(UIScreen.main.bounds.width * 0.45))
                
                List {
                    Section(header: Text("Lenses")) {
                        ForEach(lenseSizes){part in
                            NavigationLink(destination: EditPartsMountingView(part: part)) {
                                
                                PartsMountingListRow(part: part)

                            }

                        }
                        

                    }
                    
                    
                    Section(header: Text("Rasberry Pies")) {
                        Text("Built Cabinet View")
                        Text("Built Cabinet View")
                        Text("Built Cabinet View")
                        
                        
                    }
                }.onAppear(perform: {
                    //Function to get quanitity values
                    
                    
                    
                    
                    func updateQuantityValuesLense(partNameQ: String,indexPoint: Int){
                        self.ref.child("Inventory").child("Camera Parts").child(partNameQ).child("Total Quantity").getData(completion:  { error, snapshot in
                            guard error == nil else {
                              print(error!.localizedDescription)

                                print("supposes to change to zero")

                                    //Apped Value to the array with 0 quantity
                                    lenseSizes.remove(at: indexPoint)
                                    lenseSizes.insert(PartandMounting(partName: partNameQ, partType: "Camera Parts", quantityLeft: 0), at: indexPoint)
                                return;

                                
                                
                            
                            }
                            let partValue = snapshot?.value as? Int ;
                            
                            if partValue != nil{
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {

                                    print("This is the part value stored\(partValue!)")
                                    //Apped Value to the array with pulled quantity
                                    lenseSizes.remove(at: indexPoint)
                                    lenseSizes.insert(PartandMounting(partName: partNameQ, partType: "Camera Parts", quantityLeft: partValue!
                                                                     ), at: indexPoint)

                                  

                                }
                                
                            }

                          })
                        
                       print("update Quantity function did run")
                    }
                    updateQuantityValuesLense(partNameQ: "2 mm Lense", indexPoint: 0)
                    updateQuantityValuesLense(partNameQ: "4 mm Lense", indexPoint: 1)

                    
                })
                
                .listStyle(.grouped)
                .cornerRadius(20)
            }

        
        
    }
}

struct CameraPartsView_Previews: PreviewProvider {
    static var previews: some View {
        CameraPartsView()
    }
}
//(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.85)
