//
//  NewAssembleKitView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 7/11/22.
//

import SwiftUI

struct KitView: View {
    @State private var isShowingSubmitKitView = false
    @State private var isShowingTestViewKitView = false


    var body: some View{
        NavigationView{
        ZStack() {
            
            LinearGradient(colors: [.yellow,.orange], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            
            
            VStack{
                
                NavigationLink(destination: SubmitKitView(), isActive: $isShowingSubmitKitView) { EmptyView() }
                Button {
                    //Go to modal view of camera building
                   
                    isShowingSubmitKitView = true
                } label: {
                    
                    VStack{
                        Image(systemName: "square.grid.3x1.folder.badge.plus").resizable().scaledToFit().frame(width: 150.0, height: 150.0).offset(x:10,y:40)
                          
                        Text("Add Kits")
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
                NavigationLink(destination: ViewKitsView(), isActive: $isShowingTestViewKitView) { EmptyView() }
                Button {
                    isShowingTestViewKitView = true
                    //Go to modal view of cabinet building
                } label: {
                    
                    VStack{
                        Image(systemName: "doc.text.magnifyingglass").resizable().scaledToFit().frame(width: 140.0, height: 140.0).offset(y:40)
                          
                        Text("View Kits")
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
            .navigationTitle("Assemble Kit").foregroundColor(.black)


        }
        }
        }

}

struct NewAssembleKitView_Previews: PreviewProvider {
    static var previews: some View {
        KitView()
    }
}

