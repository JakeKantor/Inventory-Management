//
//  AddCabinetView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 7/6/22.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth
import Firebase
import CodeScanner
import AVFoundation
struct AddCabinetView: View {

    
    //Variable for chagning the page
    @State private var isShowingFirstPage = true
    @State private var isShowingSecondPage = false

    //FOR FUTURE USE!!!
    //Variable recieved from class
    
    //Variables for the code scanner0
    @State private var isShowingScanner = false
    @State private var iSPModemSNNumber: String?
    @State private var fontSizeISPModemSN = 25.0
    @State var iSPModemSNText = "Press to Scan ISP Modem SN"

    //Variables for the code scanner1
    @State private var isShowingScanner1 = false
    @State private var iSPModemSNNumber1: String?
    @State private var fontSizeISPModemSN1 = 25.0
    @State var iSPModemSNText1 = "Press to Scan ISP Modem MAC Address"
    
    //Variables for the code scanner2
    @State private var isShowingScanner2 = false
    @State private var iSPModemSNNumber2: String?
    @State private var fontSizeISPModemSN2 = 25.0
    @State var iSPModemSNText2 = "Press to Scan Cell Modem SN"

    

    @EnvironmentObject var user1: userType
    var nameOfUser: String
    @State private var showAlert = false

    @State private var isShowingSuccessView = false

    //Creates the reference to the Realtime Database
    @State
    var displayedSerialNumber = ""

    var ref = Database.database().reference()
    var dataref = Database.database().reference()
    
    
    //Variables for textfields
    @State private var serialNumber = ""
    @State private var ISPMODEMMODEL = ""
    @State private var CELLMODEMMACADDRES = ""
    @State private var ASTROLYTICSSN = ""
    @State private var ASTROLYTICSSERIESNUMBER = ""
    @State private var MICROTIKSN = ""

    
    
    //Selector for list picker cabinet types
    
    @State private var cabinetTypes: Array<String> = Array()
    @State private var listPickerDisplayText = "Select Cabinet Type "
    
    @State private var isShowingListPicker = false
    @State private var isShowingCompletedView = false
    
    @State private var cabinetTypeSelected: String?
    
    @State var isEditing = false
    @State var firstStart = false
    
    //Selector for list picker shell types
    
    @State private var shellTypes: Array<String> = Array()
    @State private var listPickerDisplayTextShell = "Select Shell Type"
    
    @State private var isShowingListPickerShell = false
    @State private var isShowingCompletedViewShell = false
    
    @State private var shellTypeSelected: String?
    
    @State var isEditingShell = false
    @State var firstStartShell = false
    
    
    
    //MARK: Code scanner function
    func handleScan(result: Result<ScanResult, ScanError>) {
       isShowingScanner = false
       // more code to come
    }
    
//    func toggleTorch(on: Bool) {
//        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
//        guard device.hasTorch else { print("Torch isn't available"); return }
//
//        do {
//            try device.lockForConfiguration()
//            device.torchMode = on ? .on : .off
//            // Optional thing you may want when the torch it's on, is to manipulate the level of the torch
//            if on { try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel.significand) }
//            device.unlockForConfiguration()
//        } catch {
//            print("Torch can't be used")
//        }
//    }
    //Pulls the current cabinet serial number form the database and adds one to it
    
    func pullCabinetSerialNumber(){
        self.ref.child("General Cabinet Details").child("Starting Cabinet Serial Number").getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            let serialNumberGenerated = snapshot?.value as? Int ;
            
            if serialNumberGenerated != nil{
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                    
                    serialNumber = "\(serialNumberGenerated!+1)"
                    
                }
                
                
            }
            
        });
        
        
    }
    
    
    func generateCabinetSerialNumber(){
        
        
        
        
        self.ref.child("General Cabinet Details").child("Starting Cabinet Serial Number").getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }
            let serialNumberGenerated = snapshot?.value as? Int ;
            
            if serialNumberGenerated != nil{
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                    
                    
                    self.ref.child("General Cabinet Details").child("Starting Cabinet Serial Number").setValue(serialNumberGenerated!+1)
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700)) {
                    
                    print("This is the serial number\(serialNumberGenerated)")
                    
                }
                
            }
            
        });
        
    }
    
    //Pulls the Cabinet types from firebase
    func getCabinetTypes(){
        cabinetTypes.removeAll()
        ref.child("General Cabinet Details").child("Cabinet Types").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                let key = snap.key
                cabinetTypes.append("\(key)")
            }
            print(cabinetTypes)
        }
    }
    
    //Pulls the Cabinet types from firebase
    func getShellTypes(){
        shellTypes.removeAll()
        ref.child("General Cabinet Details").child("Shell Types").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children{
                let snap = child as! DataSnapshot
                let key = snap.key
                shellTypes.append("\(key)")
            }
            print(shellTypes)
        }
    }
    
    
    
    func subtractPartsFromInventory(partName: String, quantitySubtracted: Int){
        
        //Stores the parts used in the serial number
        
        //MARK: Uncomment to add each value under serial number
//        self.ref.child("Cabinets Requiring Testing").child(serialNumber).child(partName).setValue(quantitySubtracted)
        
        //Subtracts the value from the inventory
        self.ref.child("Inventory").child("Cabinet Parts").child(partName).child("Total Quantity").getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return;
                let partValue = snapshot?.value as? Int ;
                
                if partValue == nil{
                    self.ref.child("Inventory").child("Cabinet Parts").child(partName).child("Total Quantity").setValue(0)
                    
                    
                }
                
                
            }
            let partValue = snapshot?.value as? Int ;
            
            if partValue != nil{
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                    
                    self.ref.child("Inventory").child("Cabinet Parts").child(partName).child("Total Quantity").setValue(partValue!-quantitySubtracted)
                    
                }
                
            }
            
        });
        
        
    }
    //MARK: V2
    func subtractV2Inventory(){
        subtractPartsFromInventory(partName: "02 240-48v Transformer", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "03 48VDC PS & Ch", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "04 Thermostat", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "05 Circuit Breaker", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "06 Duplex Outlet", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "07 120-12v Transformer", quantitySubtracted: 2)
        subtractPartsFromInventory(partName: "08 Din Rail", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "09* Electronics Wiring", quantitySubtracted: 6)
        subtractPartsFromInventory(partName: "10 2-1 12V Power Pigtail", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "11* Power Cable", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "12 Cabinet Grounding Cable", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "13 Modem Patch Cable 3ft", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "13B Modem Patch Cable 2ft", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "13C Modem Patch Cable 1ft", quantitySubtracted: 2)
        subtractPartsFromInventory(partName: "14 POE Switch Ground Wire", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "15 RG6 Connectors", quantitySubtracted: 2)
        subtractPartsFromInventory(partName: "16 Power connectors (male)", quantitySubtracted: 3)
        subtractPartsFromInventory(partName: "17 12V Power Connect (female)", quantitySubtracted: 2)
        subtractPartsFromInventory(partName: "18 Cable Modem Power Connectors", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "19 POE Switch Ground Ring", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "20 Compact Splicing Connectors", quantitySubtracted: 4)
        subtractPartsFromInventory(partName: "22 Cable Modem", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "23 Cell Modem", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "24 Coax Cable", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "25 Coax Ground", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "25A 16 Port POE Switch", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "25B new Microtik", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "26 Screw hole Cable Tie", quantitySubtracted: 4)
        subtractPartsFromInventory(partName: "27 Metal Cab Label", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "28* Fan Filter", quantitySubtracted: 2)
        subtractPartsFromInventory(partName: "29* Cooling Fan", quantitySubtracted: 2)
        subtractPartsFromInventory(partName: "30* 2 IN PVC Exhuast Tube", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "31* 2 IN Caps 3D Print", quantitySubtracted: 2)
        subtractPartsFromInventory(partName: "32 Intake Fan Screw", quantitySubtracted: 4)
        subtractPartsFromInventory(partName: "33 Exhaust Fan Screw", quantitySubtracted: 4)
        subtractPartsFromInventory(partName: "34 Exhaust Base Screw", quantitySubtracted: 4)
        subtractPartsFromInventory(partName: "35 Nylon Locknut", quantitySubtracted: 12)
        subtractPartsFromInventory(partName: "36 Self Tapping Screw", quantitySubtracted: 4)
        subtractPartsFromInventory(partName: "37 Shell Ground Screw", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "38 Black Mounting Screw", quantitySubtracted: 21)
        subtractPartsFromInventory(partName: "39 Copper Grounding Lug", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "40 2 IN Terminal Adapter", quantitySubtracted: 2)
        subtractPartsFromInventory(partName: "41 Power Cable Gland", quantitySubtracted: 2)
        subtractPartsFromInventory(partName: "42 2-1 IN PVC Reducer Bushing", quantitySubtracted: 2)
        subtractPartsFromInventory(partName: "43 2 IN Plastic Bushing", quantitySubtracted: 2)
        subtractPartsFromInventory(partName: "44 2 IN Steel Lock Nut", quantitySubtracted: 2)
        subtractPartsFromInventory(partName: "45 1 IN Steel Lock Nut", quantitySubtracted: 3)
        subtractPartsFromInventory(partName: "46 Cabinet Shell Ground", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "47 1 IN Terminal Adapter", quantitySubtracted: 3)
    }
    //MARK: Partial Retrofit
    func subtractPartialRetrofitInventory(){
        subtractV2Inventory()
        subtractPartsFromInventory(partName: "51 Nvidia Jetson Nano Board (2GB)", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "52 Step Down Power Cable", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "53 Camera Module", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "54 Alluminum Housinge", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "55 Cooling Fan Attachment", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "56 SanDisk Flash Drive", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "57 SanDisk SD Card", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "58 3D Printed Camera Post", quantitySubtracted: 1)
        subtractPartsFromInventory(partName: "59 Mounting Screws", quantitySubtracted: 4)
        subtractPartsFromInventory(partName: "60 Sercurity Screws", quantitySubtracted: 4)
    }
    //MARK: Full Retrofit
    func subtractFullRetrofitInventory(){
        subtractV2Inventory()
        subtractPartialRetrofitInventory()
        subtractPartsFromInventory(partName: "48 Industrial Battery", quantitySubtracted: 4)
        subtractPartsFromInventory(partName: "49 Battery Connectors", quantitySubtracted: 2)
        subtractPartsFromInventory(partName: "50 Battery Holder", quantitySubtracted: 1)
        
    }
    var body: some View {
        ZStack {
            LinearGradient(colors: [.yellow,.orange], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()

            VStack(spacing: 20 ){
                
                //MARK: Start Group
                if isShowingFirstPage{
                
                Group{
                //MARK: Serial number textfield

                VStack(alignment: .leading, spacing: 0) {
                    
                    //serial number textfield
                    TextField("",text: $serialNumber)

                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .placeholder(when: serialNumber.isEmpty) {
                            Text("Cabinet Serial Number").foregroundColor(.black)

                                .bold()

                            
                            
                        }
                    
                    
                    Rectangle()
                        .alignmentGuide(.trailing) { d in d[.leading] }
                        .frame(width: UIScreen.main.bounds.width * 0.92, height: 1)
                        .foregroundColor(.black)
                        .padding()
                        .offset(x:-12)
                    
                }.padding(.leading, 15.0)
                    .onAppear {
                        pullCabinetSerialNumber()
                        
                        
                        
                    }
                    
                    
                    
                    //MARK: List Picker Shell Types

                    //List Picker Shell Types !!SAVE AS SEPERATE OBJECT TO REFRACTOR

                    VStack(spacing: 0){

                        Button {
                            if isShowingListPickerShell == false{
                                isShowingListPickerShell = true

                            }else if isShowingListPickerShell == true{
                                isShowingListPickerShell = false
                            }



                        } label: {
                            HStack {
                                Text(listPickerDisplayTextShell).foregroundColor(.black).font(.system(size: 25))

                                Spacer().frame(width: 10)

                                if isShowingListPickerShell == false{
                                    Image(systemName: "arrowtriangle.down.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .trailing)
                                        .foregroundColor(.black)
                                        .font(Font.title.weight(.light))
                                }else if isShowingListPickerShell == true{
                                    Image(systemName: "arrowtriangle.up.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .trailing)
                                        .foregroundColor(.black)
                                        .font(Font.title.weight(.light))


                                }



                            }
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.06)
                            .background(Rectangle().fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.7)).shadow(radius: 3))
                            .cornerRadius(10)

                        }
                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)

                        if isShowingListPickerShell == false{

                        }else if isShowingListPickerShell == true{
                            List(shellTypes, id: \.self, selection: $shellTypeSelected) { index in
                                Text(index)
                            }
                            .environment(\.editMode, .constant(self.isEditingShell ? EditMode.active : EditMode.inactive)).animation(Animation.spring())

                            .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.2)
                            .background(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.7))

                            .cornerRadius(10)
                            .onAppear(){
                                getShellTypes()
                                if firstStartShell == false {
                                    self.isEditingShell.toggle()
                                    firstStartShell = true
                                }
                            }
                            .onDisappear(){
                                if self.shellTypeSelected == nil{
                                    listPickerDisplayTextShell = "Select Shell Type"
                                }else if self.shellTypeSelected != nil{
                                    listPickerDisplayTextShell = shellTypeSelected!
                                }
                            }
                        }
                    }
                    
                    
                    //MARK: List Picker Cabinet Types

                    //List Picker Cabinet Types !!SAVE AS SEPERATE OBJECT TO REFRACTOR

                    VStack(spacing: 0){

                        Button {
                            if isShowingListPicker == false{
                                isShowingListPicker = true

                            }else if isShowingListPicker == true{
                                isShowingListPicker = false
                            }



                        } label: {
                            HStack {
                                Text(listPickerDisplayText).foregroundColor(.black).font(.system(size: 25))

                                Spacer().frame(width: 10)

                                if isShowingListPicker == false{
                                    Image(systemName: "arrowtriangle.down.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .trailing)
                                        .foregroundColor(.black)
                                        .font(Font.title.weight(.light))
                                }else if isShowingListPicker == true{
                                    Image(systemName: "arrowtriangle.up.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .trailing)
                                        .foregroundColor(.black)
                                        .font(Font.title.weight(.light))


                                }



                            }
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.06)
                            .background(Rectangle().fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.7)).shadow(radius: 3))
                            .cornerRadius(10)

                        }
                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)

                        if isShowingListPicker == false{

                        }else if isShowingListPicker == true{
                            List(cabinetTypes, id: \.self, selection: $cabinetTypeSelected) { index in
                                Text(index)
                            }
                            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())

                            .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.2)
                            .background(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.7))

                            .cornerRadius(10)
                            .onAppear(){
                                getCabinetTypes()
                                if firstStart == false {
                                    self.isEditing.toggle()
                                    firstStart = true
                                }

                            }
                            .onDisappear(){
                                if self.cabinetTypeSelected == nil{
                                    listPickerDisplayText = "Select Cabinet Type"
                                }else if self.cabinetTypeSelected != nil{
                                    listPickerDisplayText = cabinetTypeSelected!
                                }
                            }
                        }
                    }
                    
                    
                    //MARK: ISP Modem Model textfield

                VStack(alignment: .leading, spacing: 0) {

                    TextField("",text: $ISPMODEMMODEL)

                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .placeholder(when: ISPMODEMMODEL.isEmpty) {
                            Text("ISP Modem Model").foregroundColor(.black)

                                .bold()



                        }


                    Rectangle()
                        .alignmentGuide(.trailing) { d in d[.leading] }
                        .frame(width: UIScreen.main.bounds.width * 0.92, height: 1)
                        .foregroundColor(.black)
                        .padding()
                        .offset(x:-12)

                }.padding(.leading, 15.0)

                    
                    
                    
                    //MARK: ISP Modem SN Scanner
                Button {
                    
                    
                    isShowingScanner = true
                    
                }label: {
                    Text(iSPModemSNText)
                        .foregroundColor(.black).font(.system(size: fontSizeISPModemSN))
                        .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.02)
                        .foregroundColor(.black)
                        .padding(20.0)
                    
                }
                    .background(Rectangle().fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.7)).shadow(radius: 3))

                    .cornerRadius(10)


                    //MARK: ISP Modem MAC Scanner

                       Button {


                           isShowingScanner1 = true


                       }label: {
                           Text(iSPModemSNText1)
                               .foregroundColor(.black).font(.system(size: fontSizeISPModemSN1))
                               .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.02)
                               .foregroundColor(.black)
                               .padding(20.0)

                       }
                           .background(Rectangle().fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.7)).shadow(radius: 3))

                           .cornerRadius(10)




                    
                    
                    
                    
                    
                    
                    





                }
                    Button{
                        
                        
                        //Move to next page and check to see if textfields are complete
                        if serialNumber.isEmpty || listPickerDisplayTextShell == "Select Shell Type" || listPickerDisplayText == "Select Cabinet Type" || ISPMODEMMODEL.isEmpty || iSPModemSNText == "Press to Scan ISP Modem SN" || iSPModemSNText1 == "Press to Scan ISP Modem MAC Address"   {
                            showAlert.toggle()
                            print("These strings are empty")
                        }else{
                            
                            
                            withAnimation{
                                
                                isShowingFirstPage.toggle()
                                isShowingSecondPage.toggle()
                            }
                            
                        }
                        
                } label: {
                    Text("NEXT")
                        .tracking(3)
                        .font(.system(size: 30, weight: .light, design: .rounded))
                        .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.02)
                        .foregroundColor(.white)
                        .padding(20.0)
                    
                }.background(Color.black.opacity(1))
                    .cornerRadius(10)
                }
//MARK: End Group
                
                
                if isShowingSecondPage{
                //MARK: Start Group

                
                
                
                    //MARK: Cell Modem SN Scanner

                   Button {


                       isShowingScanner2 = true


                   }label: {
                       Text(iSPModemSNText2)
                           .foregroundColor(.black).font(.system(size: fontSizeISPModemSN2))
                           .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.02)
                           .foregroundColor(.black)
                           .padding(20.0)

                   }
                       .background(Rectangle().fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.7)).shadow(radius: 3))
                       .cornerRadius(10)

                    //MARK: Cell Modem MAC textfield

                    VStack(alignment: .leading, spacing: 0) {

                        //Cell Modem MAC Addres textfield
                        TextField("",text: $CELLMODEMMACADDRES)

                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .placeholder(when: CELLMODEMMACADDRES.isEmpty) {
                                Text("Cell Modem MAC Address").foregroundColor(.black)

                                    .bold()



                            }


                        Rectangle()
                            .alignmentGuide(.trailing) { d in d[.leading] }
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: 1)
                            .foregroundColor(.black)
                            .padding()
                            .offset(x:-12)

                    }.padding(.leading, 15.0)



                    //MARK: Astrolytics SN textfield

                    VStack(alignment: .leading, spacing: 0) {

                        TextField("",text: $ASTROLYTICSSN)

                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .placeholder(when: ASTROLYTICSSN.isEmpty) {
                                Text("Astrolytics SN").foregroundColor(.black)

                                    .bold()



                            }


                        Rectangle()
                            .alignmentGuide(.trailing) { d in d[.leading] }
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: 1)
                            .foregroundColor(.black)
                            .padding()
                            .offset(x:-12)

                    }.padding(.leading, 15.0)

                    
                    //MARK: Astrolytics Series Number textfield

                    VStack(alignment: .leading, spacing: 0) {

                        TextField("",text: $ASTROLYTICSSERIESNUMBER)

                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .placeholder(when: ASTROLYTICSSERIESNUMBER.isEmpty) {
                                Text("Astrolytics Series Number").foregroundColor(.black)

                                    .bold()



                            }


                        Rectangle()
                            .alignmentGuide(.trailing) { d in d[.leading] }
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: 1)
                            .foregroundColor(.black)
                            .padding()
                            .offset(x:-12)

                    }.padding(.leading, 15.0)

                    
                    //MARK: Microtik SN textfield

                    VStack(alignment: .leading, spacing: 0) {

                        TextField("",text: $MICROTIKSN)

                            .foregroundColor(.black)
                            .textFieldStyle(.plain)
                            .placeholder(when: MICROTIKSN.isEmpty) {
                                Text("Microtik SN").foregroundColor(.black)

                                    .bold()



                            }


                        Rectangle()
                            .alignmentGuide(.trailing) { d in d[.leading] }
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: 1)
                            .foregroundColor(.black)
                            .padding()
                            .offset(x:-12)

                    }.padding(.leading, 15.0)

                
                
                
                Button {

                    
                    
                    
                    if iSPModemSNText2 == "Press to Scan Cell Modem SN" || CELLMODEMMACADDRES.isEmpty || ASTROLYTICSSN.isEmpty || ASTROLYTICSSERIESNUMBER.isEmpty || MICROTIKSN.isEmpty  {
                        showAlert.toggle()
                        print("These strings are empty")
                    }else {
                        self.displayedSerialNumber = serialNumber
                        
                        withAnimation{
                            
                            isShowingSuccessView.toggle()
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3000)) {
                            withAnimation{
                                
                                isShowingSuccessView.toggle()
                                
                            }
                        }
                      
                        //Firebase data
                        
                        let date = Date()
                        generateCabinetSerialNumber()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                            pullCabinetSerialNumber()
                        }
                        
                        self.ref.child("Cabinets Requiring Testing").child(serialNumber).child("Shell Type").setValue("\(listPickerDisplayTextShell)")
                        self.ref.child("Cabinets Requiring Testing").child(serialNumber).child("Interior").setValue("\("\(listPickerDisplayText)")")
                        self.ref.child("Cabinets Requiring Testing").child(serialNumber).child("ISP Modem SN").setValue("\(iSPModemSNNumber!)")
                        self.ref.child("Cabinets Requiring Testing").child(serialNumber).child("ISP Modem MAC Address").setValue("\(iSPModemSNNumber1!)")
                        self.ref.child("Cabinets Requiring Testing").child(serialNumber).child("Cell Modem SN").setValue("\(iSPModemSNNumber1!)")
                        self.ref.child("Cabinets Requiring Testing").child(serialNumber).child("ISP Modem Model").setValue("\(ISPMODEMMODEL)")
                        self.ref.child("Cabinets Requiring Testing").child(serialNumber).child("Cell Modem MAC Address").setValue("\(CELLMODEMMACADDRES)")
                        self.ref.child("Cabinets Requiring Testing").child(serialNumber).child("Astrolytics SN").setValue("\(ASTROLYTICSSN)")
                        self.ref.child("Cabinets Requiring Testing").child(serialNumber).child("Astrolytics Series Number").setValue("\(ASTROLYTICSSERIESNUMBER)")
                        self.ref.child("Cabinets Requiring Testing").child(serialNumber).child("Microtik SN").setValue("\(MICROTIKSN)")








                        
                        self.ref.child("Cabinets Requiring Testing").child(serialNumber).child("Created by").setValue("\(nameOfUser) on \(date.formatted())")
                        //MARK: Subtracts values from the inventory
                        
                        
                        if listPickerDisplayTextShell == "01A Cabinet Shell: Large"{
                            
                            //Subtract 01A from inventory
                            subtractPartsFromInventory(partName: "01A Cabinet Shell: Large", quantitySubtracted: 1)
                            
                            
                        }else if listPickerDisplayTextShell == "01B Cabinet Shell: Small"{
                            
                            
                            //Subtract 01B from inventory
                            subtractPartsFromInventory(partName: "01B Cabinet Shell: Small", quantitySubtracted: 1)
                            
                        }
                        
                        
                        if listPickerDisplayText == "Full Retrofit"{
                            subtractFullRetrofitInventory()
                            
                        }else if listPickerDisplayText == "Partial Retrofit"{
                            subtractPartialRetrofitInventory()
                            
                        }else if listPickerDisplayText == "V2"{
                            
                            subtractV2Inventory()
                        }
                     
                    
                        
                        
                        
                        
                       

                        
                    }
                    
                    

                    
                } label: {
                    Text("SUBMIT CABINET")
                        .tracking(3)
                        .font(.system(size: 30, weight: .light, design: .rounded))
                        .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.02)
                        .foregroundColor(.white)
                        .padding(20.0)
                    
                }.background(Color.black.opacity(1))
                    .cornerRadius(10)
                
                
                Spacer()
                
                //MARK: END Group
                }
                
            }
            .padding(.top, UIScreen.main.bounds.height * 0.05)

            .alert(isPresented: $showAlert) {
            
            Alert(title: Text("⚠️"), message: Text("Please complete the above fields before submitting a Cabinet."), dismissButton: .default(Text("OK")))

        }
            if isShowingSuccessView{

            SucessfullyCreatedView(cabinetSerialNumber: displayedSerialNumber)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.4, alignment: .center)
                    .zIndex(1)

                    .transition(.scale)
            }

        }
        
        //MARK: Scanner actions
        .sheet(isPresented: $isShowingScanner) {

//            CodeScannerView(codeTypes: [.qr], simulatedData: "", completion: handleScan)
            CodeScannerView(codeTypes: [.code128],scanMode: .continuous,scanInterval: 5.0, showViewfinder: true) { response in
                           if case let .success(result) = response {
                               iSPModemSNNumber = result.string
                               isShowingScanner = false
                               print(iSPModemSNNumber)
                               iSPModemSNText = "ISP Modem SN: \(iSPModemSNNumber!)"
                               fontSizeISPModemSN = 15

                        }
                       }
            
        }
        
        .sheet(isPresented: $isShowingScanner1) {
//            CodeScannerView(codeTypes: [.qr], simulatedData: "", completion: handleScan)
            CodeScannerView(codeTypes: [.code128],scanMode: .continuous,scanInterval: 5.0, showViewfinder: true) { response in
                           if case let .success(result) = response {
                               iSPModemSNNumber1 = result.string
                               isShowingScanner1 = false
                               print(iSPModemSNNumber1)
                               iSPModemSNText1 = "ISP Modem MAC Address: \(iSPModemSNNumber1!)"
                               fontSizeISPModemSN1 = 15
                           }
                       }
            
        }
        
        .sheet(isPresented: $isShowingScanner2) {
//            CodeScannerView(codeTypes: [.qr], simulatedData: "", completion: handleScan)
            CodeScannerView(codeTypes: [.code128],scanMode: .continuous,scanInterval: 5.0, showViewfinder: true) { response in
                           if case let .success(result) = response {
                               iSPModemSNNumber2 = result.string
                               isShowingScanner2 = false
                               print(iSPModemSNNumber2)
                               iSPModemSNText2 = "Cell Modem SN: \(iSPModemSNNumber2!)"
                               fontSizeISPModemSN2 = 15
                           }
                       }
            
        }
    }


}

struct AddCabinetView_Previews: PreviewProvider {
    static var previews: some View {
        AddCabinetView(nameOfUser: "")
    }
}
