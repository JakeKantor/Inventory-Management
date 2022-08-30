//
//  ProductionView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/27/22.
//

import SwiftUI
struct ProductionView: View {
    
    var nameOfUser: String
    
    @State private var isShowingAddCameraView = false
    @State private var isShowingAddCabinetView = false


    
    var body: some View{
        NavigationView{
        ZStack() {
            
            LinearGradient(colors: [.yellow,.orange], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            
            
            VStack{
                
                NavigationLink(destination: AddCameraView(), isActive: $isShowingAddCameraView) { EmptyView() }
                Button {
                    //Go to modal view of camera building
                   
                    isShowingAddCameraView = true
                } label: {
                    
                    VStack{
                        Image(systemName: "camera").resizable().scaledToFit().frame(width: 150.0, height: 150.0).offset(y:40)
                          
                        Text("Add Camera")
                            .font(.system(size: 40, weight: .semibold, design: .rounded))

                            .frame(width: UIScreen.main.bounds.width * 0.7 , height: UIScreen.main.bounds.height * 0.05)
                            .padding(40.0)
                        
                    }  .background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1))
                        .cornerRadius(10)
                        .padding(.top,UIScreen.main.bounds.height * 0.12)
                        .foregroundColor(.black)

                
                        
                        .cornerRadius(20)
                        
                }
                
                Spacer().frame(height:20)
                NavigationLink(destination: AddCabinetView(nameOfUser: nameOfUser), isActive: $isShowingAddCabinetView) { EmptyView() }
                Button {
                    isShowingAddCabinetView = true
                    //Go to modal view of cabinet building
                    
                    print("This is the name of the user \(nameOfUser)")
                } label: {
                    
                    VStack{
                        Image("cabinet").resizable().scaledToFit().frame(width: 150.0, height: 150.0).offset(y:40)
                          
                        Text("Add Cabinet")
                            .font(.system(size: 40, weight: .semibold, design: .rounded))
                            .frame(width: UIScreen.main.bounds.width * 0.7 , height: UIScreen.main.bounds.height * 0.05)
                            .padding(40.0)
                            .foregroundColor(.black)
                        
                    }  .background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1))
                        .cornerRadius(10)
                        .padding(.bottom,UIScreen.main.bounds.height * 0.12)

                
//                    (UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.1))
                        
                        .cornerRadius(20)
                        
                }


            }
            .navigationTitle("Production").foregroundColor(.black)


        }
        }
        }

}

struct ProductionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductionView(nameOfUser: "").previewDevice("iPhone 13 Pro Max")
        ProductionView(nameOfUser: "").previewDevice("iPhone 12")
        ProductionView(nameOfUser: "").previewDevice("iPhone 8")
    }
}
