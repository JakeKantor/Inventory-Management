//
//  AssembleKitView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/27/22.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseAuth

struct SubmitKitView: View {
    //Variables for assembleKit View
    
    @State private var siteName = ""
    @State private var siteNameTransfer = ""

    @State private var location = ""
    @State private var subcontractor = ""
    @State private var pickupDate = Date()
    
    //Assemble kit variables for button text
    @State private var cameraButtonText = "No Cameras Selected"
    @State private var cabinetButtonText = "No Cabinet Selected"
    
    //Variables for swtiching the tabs
    init() {
        
        UITableView.appearance().backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 0.0)
        
    }
    
    
    //Sets the reference point for firebase
    var ref = Database.database().reference()
    
    
    
    //Array that stores the serial numbers of hte cameras
    @State private var cameraSerialNumbers: Array<String> = Array()
    
    //Listener for get camera serial numbers
    
    @State private var getCameraSerialNumberComplete = false
    
    
    //Selector for list picker cabinets
    
    @State private var cabinetTestSerialNumbers: Array<String> = Array()
    @State private var cabinetsSelected = "Select Cabinets"
    
    @State private var isShowingListPicker = false
    @State private var isShowingCompletedView = false

    @State private var cabinetSelection: String?
    @State private var cabinetComponents: Array<String> = Array()
    
    @State var isEditing = false
    @State var firstStart = false
    
    
    
    
    func getCabinetSerialNumber(){
        cabinetTestSerialNumbers.removeAll()
       //Array to the serial numbers
       ref.child("Tested Cabinets").observeSingleEvent(of: .value) { (snapshot) in
           for child in snapshot.children{
               
               let snap = child as! DataSnapshot
               let key = snap.key
  

               
               cabinetTestSerialNumbers.append("\(key)")
               
           }
            print(cabinetTestSerialNumbers)
       }

   }
    
    
    //Function Pulls all the components added to the cabinets requiring testing and stores in array
    func getCabinetComponents(){
        cabinetComponents.removeAll()
        
        //Array to the serial numbers
        ref.child("Tested Cabinets").child(cabinetSelection!).observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children{
                
                let snap = child as! DataSnapshot
                let key = snap.key
                
                
                cabinetComponents.append("\(key)")
                
            }
            print(cabinetComponents)
        }
        
    }
    
    
    var body: some View{
        NavigationLink(destination: ViewIndividualKitView(specficKitName: siteNameTransfer, nameOfLocation: "Kendall", nameOfSubcontractor: "Eyecast", thePickupDate: "now", theCabinetNumber: "Cabinet 1111", theComment: "None"), isActive: $isShowingCompletedView) { EmptyView() }
        
        
        
        NavigationView{
            
            ZStack(){
                LinearGradient(colors: [.yellow,.orange], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                
                
                VStack{
                    
                    
                    //serial number textfield
                    VStack(alignment: .leading, spacing: 0) {
                        
                        //serial number textfield
                        TextField("",text: $siteName)
                        
                            .textFieldStyle(.plain)
                            .placeholder(when: siteName.isEmpty) {
                                Text("Site Name").foregroundColor(.black)
                                    .bold()
                                
                                
                            }
                        
                        
                        Rectangle()
                            .alignmentGuide(.trailing) { d in d[.leading] }
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: 1)
                            .foregroundColor(.black)
                            .padding()
                            .offset(x:-15)
                        
                    }.padding(.leading, 15.0)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.03)
                    
                    
                    
                    
                    //Location textfield
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        TextField("",text: $location)
                        
                            .textFieldStyle(.plain)
                            .placeholder(when: location.isEmpty) {
                                Text("Location").foregroundColor(.black)
                                    .bold()
                                
                                
                            }
                        
                        
                        Rectangle()
                            .alignmentGuide(.trailing) { d in d[.leading] }
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: 1)
                            .foregroundColor(.black)
                            .padding()
                            .offset(x:-15)
                        
                    }.padding(.leading, 15.0)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.03)
                    
                    
                    
                    
                    
                    
                    //subcontractor textfield
                    
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        TextField("",text: $subcontractor)
                        
                            .textFieldStyle(.plain)
                            .placeholder(when: subcontractor.isEmpty) {
                                Text("Subcontractor").foregroundColor(.black)
                                    .bold()
                                
                                
                            }
                        
                        
                        Rectangle()
                            .alignmentGuide(.trailing) { d in d[.leading] }
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: 1)
                            .foregroundColor(.black)
                            .padding()
                            .offset(x:-15)
                        
                    }.padding(.leading, 15.0)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.04)
                    
                    
                    
                    //Datepicker to select pickup date
                    VStack(alignment: .leading, spacing: 0) {
                        DatePicker(selection: $pickupDate) {
                            Text("Enter Pickup Date").foregroundColor(.black)
                                .bold()
                                .frame(width: UIScreen.main.bounds.width * 0.37, height: 1, alignment: .leading)
                            
                            
                            
                        }.frame(width: UIScreen.main.bounds.width * 0.8, height: 1, alignment: .leading)
                        Spacer().frame(height: 10)
                        
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: 1)
                            .alignmentGuide(.trailing) { d in d[.leading] }
                            .foregroundColor(.black)
                            .padding()
                            .offset(x:-15)
                        
                    }.padding(.leading, 15.0)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.03)
                    
                    
                    
                    
                    
                    
                    //Camera Selector
                    
                    VStack(spacing: 0){
                        
                        Button {
                            if isShowingListPicker == false{
                                isShowingListPicker = true
                                
                            }else if isShowingListPicker == true{
                                isShowingListPicker = false
                            }
                            
                            
                            
                        } label: {
                            HStack {
                                Text(cabinetsSelected).foregroundColor(.black).font(.system(size: 25))
                                
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
                            .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.05)
                            .background(Rectangle().fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.7)).shadow(radius: 3))
                            
                            .border(.black, width: 1.0)
                        }
                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)
                        
                        if isShowingListPicker == false{
                            
                        }else if isShowingListPicker == true{
                            List(cabinetTestSerialNumbers, id: \.self, selection: $cabinetSelection) { index in
                                Text(index)
                            }
                            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                            
                            .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.2)
                            .background(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.7))
                            
                            .cornerRadius(10)
                            .onAppear(){
                                getCabinetSerialNumber()
                                
                                
                                if firstStart == false {
                                    self.isEditing.toggle()
                                    firstStart = true
                                }
                                
                                
                            }
                            .onDisappear(){
                                
                                
                                if self.cabinetSelection == nil{
                                    
                                    cabinetsSelected = "Select Cabinets"
                                    
                                }else if self.cabinetSelection != nil{
                                    cabinetsSelected = cabinetSelection!
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                        
                        
                        Spacer()
                        
                    }
                    
                    //                    .padding(.bottom, UIScreen.main.bounds.height * 0.02)
                    
                    
                    //Cabinet Selector
                    
                    
                    
                    
                    //                    .padding(.bottom, UIScreen.main.bounds.height * 0.03)
                    
                    
                    
                    
                    Button {
                        
                        //Submits the kit data to firebase
                        getCabinetComponents()

                        
                        //Temporarily remove
                        
                                                self.ref.child("Kits").child("\(siteName)")
                                                self.ref.child("Kits").child("\(siteName)").child("Site Name").setValue(siteName)
                                                self.ref.child("Kits").child("\(siteName)").child("Location").setValue(location)
                                                self.ref.child("Kits").child("\(siteName)").child("Subcontractor").setValue(subcontractor)
                                                self.ref.child("Kits").child("\(siteName)").child("Pickup Date").setValue("\(pickupDate.formatted())")
                                                self.ref.child("Kits").child("\(siteName)").child("Cameras Used").setValue(cameraButtonText)
                        self.ref.child("Kits").child("\(siteName)").child("Comments Made").setValue("None")

                        
                        //Store the cabinet selected
                        
                        
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                            var counter = 0
                            var indexP = 0


                            while counter < cabinetComponents.count{
                              
                                print("begining of looop\(counter)")


                                //!! Function that adds old quanitity of parts to new value of parts
                                self.ref.child("Tested Cabinets").child(cabinetSelection!).child(cabinetComponents[counter]).getData(completion:  { error, snapshot in
                                    guard error == nil else {
                                      print(error!.localizedDescription)
                                      return;
                                        let partQuantity = snapshot?.value as? Int ;



                                    }
                                    let partValue = snapshot?.value as? String ;

                                    print("This is the part value\(partValue)")
                                  
                                    
                                    self.ref.child("Kits").child(siteName).child("Cabinet Used").child(cabinetSelection!).child(cabinetComponents[indexP]).setValue(partValue)

                                    indexP += 1


                                  });
                               
                                print("current cabinet quanitiy\(cabinetComponents[counter])")

                                print("current index \(counter)")

                                counter += 1

                              
                         
                                
                                

                            }
                            

                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                            self.ref.child("Tested Cabinets").child(cabinetSelection!).removeValue()

                            }
                            print("These are the cabinet components\(self.cabinetComponents)")
                        }
                        
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                            siteNameTransfer = siteName
                            
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                            isShowingCompletedView = true
                           
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                            siteName = ""
                            location = ""
                            subcontractor = ""
                            pickupDate = Date()
                            cabinetsSelected = "Select Cabinets"
                            
                        }
                        
                        
                        
                    } label: {
                        Text("SUBMIT KIT")
                            .tracking(3)
                            .font(.system(size: 24, weight: .light, design: .rounded))
                            .frame(width: UIScreen.main.bounds.width * 0.868 , height: UIScreen.main.bounds.height * 0.02)
                            .foregroundColor(.white)
                            .padding(20.0)
                        
                        
                        
                    }.background(Color.black.opacity(0.7))
                        .cornerRadius(20)
                    
                    
                    
                    Spacer()
                    
                }.onAppear {
                    siteName = ""

                }
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        
    }
    
}

struct AssembleKitView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitKitView().previewDevice("iPhone 13 Pro Max")
        SubmitKitView().previewDevice("iPhone 12")
        SubmitKitView().previewDevice("iPhone 8")
    }
}
