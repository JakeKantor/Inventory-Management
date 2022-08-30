//
//  AddCameraView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/24/22.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth
import Firebase

struct AddCameraView: View {
    //FOR FUTURE USE!!!
    //Variable recieved from class
    @EnvironmentObject var user1: userType

    
    //Creates the reference to the Realtime Database
    
    var ref = Database.database().reference()
    var dataref = Database.database().reference()

    @State private var serialNumber = ""

    

    
    
    
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.yellow,.orange], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            VStack(spacing: 20 ){
                
                
                
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    //serial number textfield
                        TextField("",text: $serialNumber)

                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .placeholder(when: serialNumber.isEmpty) {
                                Text("Serial Number").foregroundColor(.white)
                                    .bold()
                    
                                
                            }

                        
                    Rectangle()
                        .alignmentGuide(.trailing) { d in d[.leading] }
                        .frame(width: 150, height: 1)
                            .foregroundColor(.white)
                            .padding()
                            .offset(x:-15)

                }.padding(.leading, 15.0)
                

                Button {
                    //Firebase data
                    self.ref.child("Cameras Requiring Testing").child(serialNumber).child("Rasberry Pi(s)").setValue(1)
                   

                    
                } label: {
                    Text("SUBMIT CAMERA")
                        .tracking(3)
                        .font(.system(size: 30, weight: .light, design: .rounded))
                        .frame(width: UIScreen.main.bounds.width * 0.85 , height: UIScreen.main.bounds.height * 0.05)
                        .foregroundColor(.white)
                        .padding(20.0)

                }.background(Color.black.opacity(0.7))
                    .cornerRadius(20)

            }
            
        }
    }
}



struct AddCameraView_Previews: PreviewProvider {
    static var previews: some View {
        
  
        AddCameraView().previewDevice("iPhone 13 Pro Max")
        
            AddCameraView().previewDevice("iPhone 12")
        AddCameraView().previewDevice("iPhone 8")

    }
}
