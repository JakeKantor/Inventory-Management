//
//  CabinetPartsView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/29/22.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct CabinetPartsView: View {
    
    var ref = Database.database().reference()

    init() {
        
        UITableView.appearance().backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 0.0)
        
    }
    
    
    
    //MARK: Testing Arrary
    @State var lenseSizes = [PartandMounting(partName: "48 V",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "50 V",partType: "Cabinet Parts", quantityLeft: 0)]
    
    
    //MARK: Empty Casings
    @State var emptyCasings = [PartandMounting(partName: "01A Cabinet Shell: Large",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "01B Cabinet Shell: Small",partType: "Cabinet Parts", quantityLeft: 0)]
    
    
    //MARK: Power
    @State var power = [PartandMounting(partName: "02 240-48v Transformer",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "03 48VDC PS & Ch",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "04 Thermostat",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "05 Circuit Breaker",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "06 Duplex Outlet",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "07 120-12v Transformer",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "08 Din Rail",partType: "Cabinet Parts", quantityLeft: 0)]
    
    
    //MARK: Wires and Connectors
    @State var wiresAndConnector = [PartandMounting(partName: "09* Electronics Wiring",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "10 2-1 12V Power Pigtail",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "11* Power Cable",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "12 Cabinet Grounding Cable",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "13 Modem Patch Cable 3ft",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "13B Modem Patch Cable 2ft",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "13C Modem Patch Cable 1ft",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "14 POE Switch Ground Wire",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "15 RG6 Connectors",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "16 Power connectors (male)",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "17 12V Power Connect (female)",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "18 Cable Modem Power Connectors",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "19 POE Switch Ground Ring",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "20 Compact Splicing Connectors",partType: "Cabinet Parts", quantityLeft: 0)]
    
    
    //MARK: Internet
    @State var internet = [PartandMounting(partName: "22 Cable Modem",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "23 Cell Modem",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "24 Coax Cable",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "25 Coax Ground",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "25A 16 Port POE Switch",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "25B new Microtik",partType: "Cabinet Parts", quantityLeft: 0)]
    
    
    //MARK: Organization and Labeling
    @State var organizationAndLabeling = [PartandMounting(partName: "26 Screw hole Cable Tie",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "27 Metal Cab Label",partType: "Cabinet Parts", quantityLeft: 0)]
    

    //MARK: Fans
    //All of these parts still require assembly
    @State var fans = [PartandMounting(partName: "28* Fan Filter",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "29* Cooling Fan",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "30* 2 IN PVC Exhuast Tube",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "31* 2 IN Caps 3D Print",partType: "Cabinet Parts", quantityLeft: 0)]
    
    //MARK: Screws
    @State var screws = [PartandMounting(partName: "32 Intake Fan Screw",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "33 Exhaust Fan Screw",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "34 Exhaust Base Screw",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "35 Nylon Locknut",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "36 Self Tapping Screw",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "37 Shell Ground Screw",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "38 Black Mounting Screw",partType: "Cabinet Parts", quantityLeft: 0)]
    
    
    //MARK: Cabinet Connections
    @State var cabinetConnections = [PartandMounting(partName: "39 Copper Grounding Lug",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "40 2 IN Terminal Adapter",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "41 Power Cable Gland",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "42 2-1 IN PVC Reducer Bushing",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "43 2 IN Plastic Bushing",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "44 2 IN Steel Lock Nut",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "45 1 IN Steel Lock Nut",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "46 Cabinet Shell Ground",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "47 1 IN Terminal Adapter",partType: "Cabinet Parts", quantityLeft: 0)]
    
    
    //MARK: Battery
    @State var battery = [PartandMounting(partName: "48 Industrial Battery",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "49 Battery Connectors",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "50 Battery Holder",partType: "Cabinet Parts", quantityLeft: 0)]
    
    
    //MARK: Astrolytiks Engine
    @State var astrolytiksEngine = [PartandMounting(partName: "51 Nvidia Jetson Nano Board (2GB)",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "52 Step Down Power Cable",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "53 Camera Module",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "54 Alluminum Housing",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "55 Cooling Fan Attachment",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "56 SanDisk Flash Drive",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "57 SanDisk SD Card",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "58 3D Printed Camera Post",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "59 Mounting Screws",partType: "Cabinet Parts", quantityLeft: 0),PartandMounting(partName: "60 Sercurity Screws",partType: "Cabinet Parts", quantityLeft: 0)]
    

    var body: some View {
        
        
    
        

            VStack {
                
                Text("Cabinet Parts")
                    .foregroundColor(.black)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding(.top, (UIScreen.main.bounds.height * 0.05))
                    .padding(.leading, -(UIScreen.main.bounds.width * 0.45))
                
                List {
//                    Section(header: Text("Voltages")) {
//                        ForEach(lenseSizes){part in
//                            NavigationLink(destination: EditPartsMountingView(part: part)) {
//                                
//                                PartsMountingListRow(part: part)
//
//                            }
//
//                        }
//                        
//
//                    }
                    
                    
                    Section(header: Text("Empty Casings")) {
                        
                        //Insert the new array here
                        ForEach(emptyCasings){part in
                            NavigationLink(destination: EditPartsMountingView(part: part)) {
                                
                                PartsMountingListRow(part: part)

                            }

                        }
                        

                    }
                    Section(header: Text("Power")) {
                        
                        //Insert the new array here
                        ForEach(power){part in
                            NavigationLink(destination: EditPartsMountingView(part: part)) {
                                
                                PartsMountingListRow(part: part)

                            }

                        }
                        

                    }
                    Section(header: Text("Wires and Connectors")) {
                        
                        //Insert the new array here
                        ForEach(wiresAndConnector){part in
                            NavigationLink(destination: EditPartsMountingView(part: part)) {
                                
                                PartsMountingListRow(part: part)

                            }

                        }
                        

                    }
                    
                    Section(header: Text("Internet")) {
                        
                        //Insert the new array here
                        ForEach(internet){part in
                            NavigationLink(destination: EditPartsMountingView(part: part)) {
                                
                                PartsMountingListRow(part: part)

                            }

                        }
                        

                    }
                    
                    Section(header: Text("Organization and Labeling")) {
                        
                        //Insert the new array here
                        ForEach(organizationAndLabeling){part in
                            NavigationLink(destination: EditPartsMountingView(part: part)) {
                                
                                PartsMountingListRow(part: part)

                            }

                        }
                        

                    }
                    
                    
                    Section(header: Text("Fans")) {
                        
                        //Insert the new array here
                        ForEach(fans){part in
                            NavigationLink(destination: EditPartsMountingView(part: part)) {
                                
                                PartsMountingListRow(part: part)

                            }

                        }
                        

                    }
                    Section(header: Text("Screws")) {
                        
                        //Insert the new array here
                        ForEach(screws){part in
                            NavigationLink(destination: EditPartsMountingView(part: part)) {
                                
                                PartsMountingListRow(part: part)

                            }

                        }
                        

                    }
                    
                    
                    Section(header: Text("Cabinet Connections")) {
                        
                        //Insert the new array here
                        ForEach(cabinetConnections){part in
                            NavigationLink(destination: EditPartsMountingView(part: part)) {
                                
                                PartsMountingListRow(part: part)

                            }

                        }
                        

                    }
                    

                    
                    Section(header: Text("Battery")) {
                        
                        //Insert the new array here
                        ForEach(battery){part in
                            NavigationLink(destination: EditPartsMountingView(part: part)) {
                                
                                PartsMountingListRow(part: part)

                            }

                        }
                        

                    }
                    
                    
                    Section(header: Text("Astrolytiks Engine")) {
                        
                        //Insert the new array here
                        ForEach(astrolytiksEngine){part in
                            NavigationLink(destination: EditPartsMountingView(part: part)) {
                                
                                PartsMountingListRow(part: part)

                            }

                        }
                        

                    }
                    
                    
                    
                }.onAppear(perform: {
                    //Function to get quanitity values
                    
                    
                    
                    //MARK: update0
                    func updateQuantityValuesLense(partNameQ: String,indexPoint: Int){
                        self.ref.child("Inventory").child("Cabinet Parts").child(partNameQ).child("Total Quantity").getData(completion:  { error, snapshot in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                print("supposes to change to zero")
                                lenseSizes.remove(at: indexPoint)
                                lenseSizes.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: 0), at: indexPoint)
                                return;
                            }
                            let partValue = snapshot?.value as? Int ;
                            if partValue != nil{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                    print("This is the part value stored\(partValue!)")
                                    lenseSizes.remove(at: indexPoint)
                                    lenseSizes.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: partValue!), at: indexPoint)
                                }
                            }
                        })
                        
                        print("update Quantity function did run")
                    }
                    updateQuantityValuesLense(partNameQ: "48 V", indexPoint: 0)
                    updateQuantityValuesLense(partNameQ: "50 V", indexPoint: 1)
                    
                    //MARK: update1
                    func updateQuantityValuesLense1(partNameQ: String,indexPoint: Int){
                        self.ref.child("Inventory").child("Cabinet Parts").child(partNameQ).child("Total Quantity").getData(completion:  { error, snapshot in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                print("supposes to change to zero")
                                emptyCasings.remove(at: indexPoint)
                                emptyCasings.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: 0), at: indexPoint)
                                return;
                            }
                            let partValue = snapshot?.value as? Int ;
                            if partValue != nil{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                    print("This is the part value stored\(partValue!)")
                                    emptyCasings.remove(at: indexPoint)
                                    emptyCasings.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: partValue!), at: indexPoint)
                                }
                            }
                        })
                        
                        print("update Quantity function did run")
                    }
                    updateQuantityValuesLense1(partNameQ: "01A Cabinet Shell: Large", indexPoint: 0)
                    updateQuantityValuesLense1(partNameQ: "01B Cabinet Shell: Small", indexPoint: 1)
                    
                    //MARK: update2
                    func updateQuantityValuesLense2(partNameQ: String,indexPoint: Int){
                        self.ref.child("Inventory").child("Cabinet Parts").child(partNameQ).child("Total Quantity").getData(completion:  { error, snapshot in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                print("supposes to change to zero")
                                power.remove(at: indexPoint)
                                power.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: 0), at: indexPoint)
                                return;
                            }
                            let partValue = snapshot?.value as? Int ;
                            if partValue != nil{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                    print("This is the part value stored\(partValue!)")
                                    power.remove(at: indexPoint)
                                    power.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: partValue!), at: indexPoint)
                                }
                            }
                        })
                        
                        print("update Quantity function did run")
                    }
                    updateQuantityValuesLense2(partNameQ: "02 240-48v Transformer", indexPoint: 0)
                    updateQuantityValuesLense2(partNameQ: "03 48VDC PS & Ch", indexPoint: 1)
                    updateQuantityValuesLense2(partNameQ: "04 Thermostat", indexPoint: 2)
                    updateQuantityValuesLense2(partNameQ: "05 Circuit Breaker", indexPoint: 3)
                    updateQuantityValuesLense2(partNameQ: "06 Duplex Outlet", indexPoint: 4)
                    updateQuantityValuesLense2(partNameQ: "07 120-12v Transformer", indexPoint: 5)
                    updateQuantityValuesLense2(partNameQ: "08 Din Rail", indexPoint: 6)
                    //MARK: update3
                    func updateQuantityValuesLense3(partNameQ: String,indexPoint: Int){
                        self.ref.child("Inventory").child("Cabinet Parts").child(partNameQ).child("Total Quantity").getData(completion:  { error, snapshot in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                print("supposes to change to zero")
                                wiresAndConnector.remove(at: indexPoint)
                                wiresAndConnector.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: 0), at: indexPoint)
                                return;
                            }
                            let partValue = snapshot?.value as? Int ;
                            if partValue != nil{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                    print("This is the part value stored\(partValue!)")
                                    wiresAndConnector.remove(at: indexPoint)
                                    wiresAndConnector.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: partValue!), at: indexPoint)
                                }
                            }
                        })
                        
                        print("update Quantity function did run")
                    }
                    updateQuantityValuesLense3(partNameQ: "09* Electronics Wiring", indexPoint: 0)
                    updateQuantityValuesLense3(partNameQ: "10 2-1 12V Power Pigtail", indexPoint: 1)
                    updateQuantityValuesLense3(partNameQ: "11* Power Cable", indexPoint: 2)
                    updateQuantityValuesLense3(partNameQ: "12 Cabinet Grounding Cable", indexPoint: 3)
                    updateQuantityValuesLense3(partNameQ: "13 Modem Patch Cable 3ft", indexPoint: 4)
                    updateQuantityValuesLense3(partNameQ: "13B Modem Patch Cable 2ft", indexPoint: 5)
                    updateQuantityValuesLense3(partNameQ: "13C Modem Patch Cable 1ft", indexPoint: 6)
                    updateQuantityValuesLense3(partNameQ: "14 POE Switch Ground Wire", indexPoint: 7)
                    updateQuantityValuesLense3(partNameQ: "15 RG6 Connectors", indexPoint: 8)
                    updateQuantityValuesLense3(partNameQ: "16 Power connectors (male)", indexPoint: 9)
                    updateQuantityValuesLense3(partNameQ: "17 12V Power Connect (female)", indexPoint: 10)
                    updateQuantityValuesLense3(partNameQ: "18 Cable Modem Power Connectors", indexPoint: 11)
                    updateQuantityValuesLense3(partNameQ: "19 POE Switch Ground Ring", indexPoint: 12)
                    updateQuantityValuesLense3(partNameQ: "20 Compact Splicing Connectors", indexPoint: 13)
                    
                    //MARK: update4
                    func updateQuantityValuesLense4(partNameQ: String,indexPoint: Int){
                        self.ref.child("Inventory").child("Cabinet Parts").child(partNameQ).child("Total Quantity").getData(completion:  { error, snapshot in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                print("supposes to change to zero")
                                internet.remove(at: indexPoint)
                                internet.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: 0), at: indexPoint)
                                return;
                            }
                            let partValue = snapshot?.value as? Int ;
                            if partValue != nil{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                    print("This is the part value stored\(partValue!)")
                                    internet.remove(at: indexPoint)
                                    internet.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: partValue!), at: indexPoint)
                                }
                            }
                        })
                        
                        print("update Quantity function did run")
                    }
                    updateQuantityValuesLense4(partNameQ: "22 Cable Modem", indexPoint: 0)
                    updateQuantityValuesLense4(partNameQ: "23 Cell Modem", indexPoint: 1)
                    updateQuantityValuesLense4(partNameQ: "24 Coax Cable", indexPoint: 2)
                    updateQuantityValuesLense4(partNameQ: "25 Coax Ground", indexPoint: 3)
                    updateQuantityValuesLense4(partNameQ: "25A 16 Port POE Switch", indexPoint: 4)
                    updateQuantityValuesLense4(partNameQ: "25B new Microtik", indexPoint: 5)

                    
                    //MARK: update5
                    func updateQuantityValuesLense5(partNameQ: String,indexPoint: Int){
                        self.ref.child("Inventory").child("Cabinet Parts").child(partNameQ).child("Total Quantity").getData(completion:  { error, snapshot in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                print("supposes to change to zero")
                                organizationAndLabeling.remove(at: indexPoint)
                                organizationAndLabeling.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: 0), at: indexPoint)
                                return;
                            }
                            let partValue = snapshot?.value as? Int ;
                            if partValue != nil{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                    print("This is the part value stored\(partValue!)")
                                    organizationAndLabeling.remove(at: indexPoint)
                                    organizationAndLabeling.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: partValue!), at: indexPoint)
                                }
                            }
                        })
                        
                        print("update Quantity function did run")
                    }
                    updateQuantityValuesLense5(partNameQ: "26 Screw hole Cable Tie", indexPoint: 0)
                    updateQuantityValuesLense5(partNameQ: "27 Metal Cab Label", indexPoint: 1)
                    
                    
                    //MARK: update6
                    func updateQuantityValuesLense6(partNameQ: String,indexPoint: Int){
                        self.ref.child("Inventory").child("Cabinet Parts").child(partNameQ).child("Total Quantity").getData(completion:  { error, snapshot in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                print("supposes to change to zero")
                                fans.remove(at: indexPoint)
                                fans.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: 0), at: indexPoint)
                                return;
                            }
                            let partValue = snapshot?.value as? Int ;
                            if partValue != nil{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                    print("This is the part value stored\(partValue!)")
                                    fans.remove(at: indexPoint)
                                    fans.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: partValue!), at: indexPoint)
                                }
                            }
                        })
                        
                        print("update Quantity function did run")
                    }
                    updateQuantityValuesLense6(partNameQ: "28* Fan Filter", indexPoint: 0)
                    updateQuantityValuesLense6(partNameQ: "29* Cooling Fan", indexPoint: 1)
                    updateQuantityValuesLense6(partNameQ: "30* 2 IN PVC Exhuast Tube", indexPoint: 2)
                    updateQuantityValuesLense6(partNameQ: "31* 2 IN Caps 3D Print", indexPoint: 3)
                    
                    
                    //MARK: update7
                    func updateQuantityValuesLense7(partNameQ: String,indexPoint: Int){
                        self.ref.child("Inventory").child("Cabinet Parts").child(partNameQ).child("Total Quantity").getData(completion:  { error, snapshot in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                print("supposes to change to zero")
                                screws.remove(at: indexPoint)
                                screws.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: 0), at: indexPoint)
                                return;
                            }
                            let partValue = snapshot?.value as? Int ;
                            if partValue != nil{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                    print("This is the part value stored\(partValue!)")
                                    screws.remove(at: indexPoint)
                                    screws.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: partValue!), at: indexPoint)
                                }
                            }
                        })
                        
                        print("update Quantity function did run")
                    }
                    updateQuantityValuesLense7(partNameQ: "32 Intake Fan Screw", indexPoint: 0)
                    updateQuantityValuesLense7(partNameQ: "33 Exhaust Fan Screw", indexPoint: 1)
                    updateQuantityValuesLense7(partNameQ: "34 Exhaust Base Screw", indexPoint: 2)
                    updateQuantityValuesLense7(partNameQ: "35 Nylon Locknut", indexPoint: 3)
                    updateQuantityValuesLense7(partNameQ: "36 Self Tapping Screw", indexPoint: 4)
                    updateQuantityValuesLense7(partNameQ: "37 Shell Ground Screw", indexPoint: 5)
                    updateQuantityValuesLense7(partNameQ: "38 Black Mounting Screw", indexPoint: 6)
                    
                    
                    //MARK: update8
                    func updateQuantityValuesLense8(partNameQ: String,indexPoint: Int){
                        self.ref.child("Inventory").child("Cabinet Parts").child(partNameQ).child("Total Quantity").getData(completion:  { error, snapshot in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                print("supposes to change to zero")
                                cabinetConnections.remove(at: indexPoint)
                                cabinetConnections.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: 0), at: indexPoint)
                                return;
                            }
                            let partValue = snapshot?.value as? Int ;
                            if partValue != nil{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                    print("This is the part value stored\(partValue!)")
                                    cabinetConnections.remove(at: indexPoint)
                                    cabinetConnections.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: partValue!), at: indexPoint)
                                }
                            }
                        })
                        
                        print("update Quantity function did run")
                    }
                    updateQuantityValuesLense8(partNameQ: "39 Copper Grounding Lug", indexPoint: 0)
                    updateQuantityValuesLense8(partNameQ: "40 2 IN Terminal Adapter", indexPoint: 1)
                    updateQuantityValuesLense8(partNameQ: "41 Power Cable Gland", indexPoint: 2)
                    updateQuantityValuesLense8(partNameQ: "42 2-1 IN PVC Reducer Bushing", indexPoint: 3)
                    updateQuantityValuesLense8(partNameQ: "43 2 IN Plastic Bushing", indexPoint: 4)
                    updateQuantityValuesLense8(partNameQ: "44 2 IN Steel Lock Nut", indexPoint: 5)
                    updateQuantityValuesLense8(partNameQ: "45 1 IN Steel Lock Nut", indexPoint: 6)
                    updateQuantityValuesLense8(partNameQ: "46 Cabinet Shell Ground", indexPoint: 7)
                    updateQuantityValuesLense8(partNameQ: "47 1 IN Terminal Adapter", indexPoint: 8)
                    
                    
                    //MARK: update9
                    func updateQuantityValuesLense9(partNameQ: String,indexPoint: Int){
                        self.ref.child("Inventory").child("Cabinet Parts").child(partNameQ).child("Total Quantity").getData(completion:  { error, snapshot in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                print("supposes to change to zero")
                                battery.remove(at: indexPoint)
                                battery.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: 0), at: indexPoint)
                                return;
                            }
                            let partValue = snapshot?.value as? Int ;
                            if partValue != nil{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                    print("This is the part value stored\(partValue!)")
                                    battery.remove(at: indexPoint)
                                    battery.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: partValue!), at: indexPoint)
                                }
                            }
                        })
                        
                        print("update Quantity function did run")
                    }
                    updateQuantityValuesLense9(partNameQ: "48 Industrial Battery", indexPoint: 0)
                    updateQuantityValuesLense9(partNameQ: "49 Battery Connectors", indexPoint: 1)
                    updateQuantityValuesLense9(partNameQ: "50 Battery Holder", indexPoint: 2)

                    //MARK: update10
                    func updateQuantityValuesLense10(partNameQ: String,indexPoint: Int){
                        self.ref.child("Inventory").child("Cabinet Parts").child(partNameQ).child("Total Quantity").getData(completion:  { error, snapshot in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                print("supposes to change to zero")
                                astrolytiksEngine.remove(at: indexPoint)
                                astrolytiksEngine.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: 0), at: indexPoint)
                                return;
                            }
                            let partValue = snapshot?.value as? Int ;
                            if partValue != nil{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                    print("This is the part value stored\(partValue!)")
                                    astrolytiksEngine.remove(at: indexPoint)
                                    astrolytiksEngine.insert(PartandMounting(partName: partNameQ, partType: "Cabinet Parts", quantityLeft: partValue!), at: indexPoint)
                                }
                            }
                        })
                        
                        print("update Quantity function did run")
                    }
                    updateQuantityValuesLense10(partNameQ: "51 Nvidia Jetson Nano Board (2GB)", indexPoint: 0)
                    updateQuantityValuesLense10(partNameQ: "52 Step Down Power Cable", indexPoint: 1)
                    updateQuantityValuesLense10(partNameQ: "53 Camera Module", indexPoint: 2)
                    updateQuantityValuesLense10(partNameQ: "54 Alluminum Housing", indexPoint: 3)
                    updateQuantityValuesLense10(partNameQ: "55 Cooling Fan Attachment", indexPoint: 4)
                    updateQuantityValuesLense10(partNameQ: "56 SanDisk Flash Drive", indexPoint: 5)
                    updateQuantityValuesLense10(partNameQ: "57 SanDisk SD Card", indexPoint: 6)
                    updateQuantityValuesLense10(partNameQ: "58 3D Printed Camera Post", indexPoint: 7)
                    updateQuantityValuesLense10(partNameQ: "59 Mounting Screws", indexPoint: 8)
                    updateQuantityValuesLense10(partNameQ: "60 Sercurity Screws", indexPoint: 9)





                })
                
                .listStyle(.grouped)
                .cornerRadius(20)
            }

        
        
    }
}

struct CabinetPartsView_Previews: PreviewProvider {
    static var previews: some View {
        CabinetPartsView()
    }
}
