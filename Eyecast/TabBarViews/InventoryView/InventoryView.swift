//
//  InventoryView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/27/22.
//

import SwiftUI

struct InventoryView: View {
    init() {
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(red: 0.961, green: 0.631, blue: 0.02, alpha: 1.0)

        }
    
    @State private var dropDownOptionSelected = ""
    @State var tabSelection = 1

    
    static var uniqueKey: String {
        UUID().uuidString
    }

    
    static let options: [DropdownOption] = [
           DropdownOption(key: uniqueKey, value: "Built Cameras"),
           DropdownOption(key: uniqueKey, value: "Built Cabinets"),
           DropdownOption(key: uniqueKey, value: "Camera Parts"),
           DropdownOption(key: uniqueKey, value: "Cabinet Parts"),
           DropdownOption(key: uniqueKey, value: "Camera Mounting"),
           DropdownOption(key: uniqueKey, value: "Cabinet Mounting"),
           DropdownOption(key: uniqueKey, value: "Tools")
       ]
    var body: some View {
        
        

        
        
        NavigationView{
            
            ZStack(){
            LinearGradient(colors: [.yellow,.orange], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                Rectangle()
                    .fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.85))
                    .frame(width: UIScreen.main.bounds.width * 0.95 , height: UIScreen.main.bounds.height * 0.70)
                    .cornerRadius(20)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.05 )
                
                VStack(alignment: .center, spacing: 0, content: {
                    
                    TabView(selection: $tabSelection) {
                        BuiltCameraViewI()
                        .tabItem {
                                            Text("Tab 1")
                            

                        }.tag(1)
                         
                        BuiltCabinetViewI()
                        .tabItem {
                                            Text("Tab 2")
                            

                        }.tag(2)
                        CameraPartsView()
                        .tabItem {
                                            Text("Tab 3")
                        }.tag(3)
                        CabinetPartsView()
                        .tabItem {
                                            Text("Tab 4")
                        }.tag(4)
                        CameraMountingView()
                        .tabItem {
                                            Text("Tab 5")
                        }.tag(5)
                        CabinetMountingView()
                        .tabItem {
                                            Text("Tab 6")
                        }.tag(6)
                        ToolsView()
                        .tabItem {
                                            Text("Tab 7")
                        }.tag(7)



                        
                        
                            }
                            .tabViewStyle(.page)
                    


                    
                    
                })
                .frame(width: UIScreen.main.bounds.width * 0.95 , height: UIScreen.main.bounds.height * 0.65)
                


                Group {
                    DropdownSelector(
                        placeholder: "Inventory Menu",
                        options: InventoryView.options,
                        onOptionSelected: { option in
                            print(option.value)
                            dropDownOptionSelected = option.value
                            if dropDownOptionSelected == "Built Cameras"{
                            tabSelection = 1
                            }else if dropDownOptionSelected == "Built Cabinets"{
                            tabSelection = 2
                            }else if dropDownOptionSelected == "Camera Parts"{
                            tabSelection = 3
                            }else if dropDownOptionSelected == "Cabinet Parts"{
                            tabSelection = 4
                            }else if dropDownOptionSelected == "Camera Mounting"{
                            tabSelection = 5
                            }else if dropDownOptionSelected == "Cabinet Mounting"{
                            tabSelection = 6
                            }else if dropDownOptionSelected == "Tools"{
                            tabSelection = 7
                            }
                            
                            print("This the current tabselection number \(tabSelection)")
                            
                    })
                    .padding(.horizontal)
                }.offset(y: -(UIScreen.main.bounds.height * 0.33))
                
                    .navigationTitle("Inventory")
            }

        }.onAppear(){
            print("did appear")
            
           //Change the menu item when view changes
                //!!FIX LATER!!
        }
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView().previewDevice("iPhone 13 Pro Max")
        InventoryView().previewDevice("iPhone 12")
        InventoryView().previewDevice("iPhone 8")
    }
}




