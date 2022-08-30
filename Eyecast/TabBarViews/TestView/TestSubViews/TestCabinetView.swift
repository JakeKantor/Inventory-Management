//
//  TestCabinetView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 7/6/22.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import AVKit

struct TestCabinetView: View {
    
    var nameOfUser: String
    
    var ref = Database.database().reference()
    //Array that stores the serial numbers of hte cameras
    @State private var cabinetTestSerialNumbers: Array<String> = Array()
    @State private var cabinetComponents: Array<String> = Array()
    @State private var cabinetsSelected = "Select"
    @State private var isShowingListPicker = false
    @State private var selection: String?
    @State var isEditing = false
    @State var firstStart = false

    
    
    //Variables for List
    @State private var testingCategoriesArray  = [[Task]]()
    @State private var showList = false
    @State private var listIndex = 5
    @State private var showTextField = false
    @State private var troubleShootingComments = ""
    @State private var showScrollView = false
    @State var imageArray: [UIImage] = []

   //Variables for scroll view
    var documentationInstructions = ["Astrolytiks","Full Cabinet Interior","Assembely Label Verification","Mikrotik(SN)","Horizontal Side View","Vertical Side View","Cell Modem Label(SN & MAC)","ISP Modem Model Label(SN & MAC)"]
    
    @State var currentImageIndex: Int
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State var image: UIImage?

//End
    
    var eyecastCabinetExternalComponents = [Task(name: "Both Fan Filters are securely attached and completely cover both Fan holes", isCompleted: false), Task(name: "All PVC Adapters and cable glands have lock nuts fully tightened", isCompleted: false),Task(name: "Grounding Lug is securely attached and there is no need for paint", isCompleted: false),Task(name: "Check For dents and scratches on exterior and photograph all 6 sides (2 Photos)", isCompleted: false),Task(name: "Wipe off any smudges or fingerprints", isCompleted: false)]
    
    
    
    var interiorComponents = [Task(name: "All metal shavings and other scraps are vacuumed out ", isCompleted: false),Task(name: "Flip upside down to make sure all components are securely attached and do not fall", isCompleted: false),Task(name: "DIN Rail components, cell & cable modem, Mikrotik, and Astrolytics are securely attached ", isCompleted: false),Task(name: "Wiring is properly stripped, secured, and is in the proper polarity ports ", isCompleted: false),Task(name: "Ethernet cables are placed into correct ports (Cable Modem in Port 1 & Cell Modem in Port 2)", isCompleted: false),Task(name: "Cable Management is neatly routed and done professionally and strapped down.", isCompleted: false),Task(name: "Ensure thermostat is set to 40 degrees C", isCompleted: false),Task(name: "Exhaust Fan is 14-16 Inch long", isCompleted: false),Task(name: "Color Scheme on cables is consistent", isCompleted: false),Task(name: "Door ground is run properly and connected with the coax cable", isCompleted: false)]
    
    
    var poweredTesting = [Task(name: "Plug Prepared AC power cable into Duplex outlet, Then wall outlet ", isCompleted: false),Task(name: "Check all lights on devices turn green and power on for the Astrolytics engine", isCompleted: false),Task(name: "Check all lights on devices turn green and power on for the Cable Modem", isCompleted: false),Task(name: "Check all lights on devices turn green and power on for the Cell modem", isCompleted: false),Task(name: "Check all lights on devices turn green and power on for the POE Switch", isCompleted: false),Task(name: "Use Multimeter to verify proper Voltages and Polarities ", isCompleted: false),Task(name: "Set Thermostat to 0 to test Fans, then reset to 40", isCompleted: false)]
    
    var retrofitVerification = [Task(name: "Verify that Astrolytics powers on", isCompleted: false),Task(name: "Cabinet Kit packaged and includes 4 industrial batteries", isCompleted: false),Task(name: "Cabinet Kit packaged and includes Wiring harness", isCompleted: false)]
    
    var mikrotikFailOverBackCameraTest = [Task(name: "Camera Test", isCompleted: false),Task(name: "Fail Over to Cell Modem", isCompleted: false),Task(name: "Fail Back to Mikrotik", isCompleted: false),Task(name: "Disconnect Power cable for Outlet first, then Duplex ", isCompleted: false)]
    
    var labelling = [Task(name: "Cabinet serial number label is securely applied to the Right side of the bottom lock on the front door", isCompleted: false),Task(name: "Interior labeling is clearly visible and securely attached (CAB SN, Assembler, Date of Assembly, QA Tester)", isCompleted: false),Task(name: "External serial number label & interior serial number match", isCompleted: false)]
    
    @State private var testingCategories = ["Eyecast Cabinet External Components ","Interior components","Powered Testing","Retrofit Verification","Mikrotik Fail Over/Back/Camera Test","Labelling","Was troubleshooting needed?","Photo Verification","Cabinet Tracking"]
    
    
    //Variables to cahgne the bounds
    @State var listPickerBounds = 0.02
    @State var listBounds = 0.55
    @State private var showAlert = false
    
    
    
    
    //Function pulls all the serial numbers from the cabients requireing testing from the database
    //MARK: FUNC Get Cab Serial Number
    func getCabinetSerialNumber(){
        
        cabinetTestSerialNumbers.removeAll()
        
        //Array to the serial numbers
        ref.child("Cabinets Requiring Testing").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children{
                
                let snap = child as! DataSnapshot
                let key = snap.key
                
                
                cabinetTestSerialNumbers.append("\(key)")
                
            }
            print(cabinetTestSerialNumbers)
        }
        
    }
    
    
    
    //Function Pulls all the components added to the cabinets requiring testing and stores in array
    //MARK: FUNC Get Cab Components
    func getCabinetComponents(){
        cabinetComponents.removeAll()
        
        //Array to the serial numbers
        ref.child("Cabinets Requiring Testing").child(selection!).observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children{
                
                let snap = child as! DataSnapshot
                let key = snap.key
                
                
                cabinetComponents.append("\(key)")
                
            }
            print(cabinetComponents)
        }
        
    }
    
    
    var body: some View {
        ZStack(){
            LinearGradient(colors: [.yellow,.orange], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            Rectangle()
                .fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.85))
                .frame(width: UIScreen.main.bounds.width * 0.95 , height: UIScreen.main.bounds.height * 0.55)
                .cornerRadius(20)
                .padding(.top, UIScreen.main.bounds.height * 0.25 )
                .padding(.bottom, UIScreen.main.bounds.height * 0.05 )
            
            
            
            //MARK: Beginning of List for entire screen
            VStack(spacing: 0){
                
                
                //MARK: List Picker
                
                VStack {
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
                        .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.06)
                        .background(Rectangle().fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.7)).shadow(radius: 3))
                        .cornerRadius(10)
                        
                    }
                    //                    .padding(.bottom, UIScreen.main.bounds.height * 0.000001)
                    
                    
                    if isShowingListPicker == false{
                        
                    }else if isShowingListPicker == true{
                        List(cabinetTestSerialNumbers, id: \.self, selection: $selection) { index in
                            Text(index)
                        }
                        .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                        
                        .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.12)
                        
                        .background(Rectangle().fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.7)).shadow(radius: 3))
                        .cornerRadius(20)
                        .padding(.bottom,UIScreen.main.bounds.height * 0.1)
                        .padding(.top,UIScreen.main.bounds.height * -0.004)
                        
                        
                        
                        .onAppear(){
                            
                            if firstStart == false {
                                self.isEditing.toggle()
                                firstStart = true
                            }
                            getCabinetSerialNumber()
                            
                            
                            listPickerBounds = 0.01
                            listBounds = 0.1201
                            
                        }
                        .onDisappear(){
                            
                            
                            
                            if self.selection != nil{
                                cabinetsSelected = selection!
                            }
                            listPickerBounds = 0.02
                            listBounds = 0.55
                            
                        }
                        
                    }
                    
                }
                .padding(.top,UIScreen.main.bounds.height * listPickerBounds)
                
                
                
                //MARK: List
                
                VStack {
                    Text(testingCategories[listIndex])
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .padding(.top, (UIScreen.main.bounds.height * 0.05))
                        .padding(.leading, (UIScreen.main.bounds.width * 0.02))
                    
                    if showList == true {
                        
                        List($testingCategoriesArray[listIndex]) { $task in
                            TaskCellView(task: $task)

                        }
                        .background((Color.clear).shadow(radius: 3))
                        .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.35)
                        //                    .background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1))


                        .cornerRadius(20)
                    }
                    //                    Text("Completed tasks count: \(tasks.filter { $0.isCompleted }.count)")
                    
                    
                    if showTextField{
                        
                        
                        //MARK: TroubleshootingTextfield
                        
                        VStack(alignment: .leading, spacing: 0) {
                            
                            //serial number textfield
                            TextField("",text: $troubleShootingComments)
                            
                                .foregroundColor(.black)
                                .textFieldStyle(.plain)
                                .placeholder(when: troubleShootingComments.isEmpty) {
                                    Text("Leave blank if not troubleshooted").foregroundColor(.black)
                                    
                                        .bold()
                                    
                                    
                                    
                                } .offset(x:9)
                            
                                .padding(.top, UIScreen.main.bounds.height * 0.2)
                            
                            Rectangle()
                                .alignmentGuide(.trailing) { d in d[.leading] }
                                .frame(width: UIScreen.main.bounds.width * 0.9, height: 1)
                                .foregroundColor(.black)
                                .padding()
                                .offset(x:-9)
                            
                            
                            
                        }.padding(.leading, 15.0)
                            .padding(.bottom,UIScreen.main.bounds.height * 0.1)
                        
                    }
                    
                    
                    //MARK: Scrollview
                    if showScrollView{
                        //Show all the scrollview info
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(0..<8,id: \.self) {num in
                                    
                                    
                                    Button {
                                        print(num)
                                        self.currentImageIndex = num
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
                                            print("This is currrentImageIndex\(self.currentImageIndex)")
                                            self.showSheet = true
                                        }
                                    } label: {
                                        
                                        if imageArray.count == num + 1{
                                            
                                          
                                            Image(uiImage: imageArray[num]).resizable().frame(width: 200, height: 200).cornerRadius(20)

                                                .frame(width: 200, height: 200)
                                                .cornerRadius(20)
                                        }else{
                                        Label {
                                            Text("\(documentationInstructions[num])")
                                            
                                        

                                        } icon: {
                                            Image(systemName: "tray.and.arrow.up.fill")

                                        }

                                           
                                        
                                        
                                        
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .frame(width: 200, height: 200)
                                            .background(.black)
                                            .cornerRadius(20)
                                        }

                                    }

                                       
                                    
                                   
                                }
                            }
                        }
                        .onAppear{
                            showList = false

                        }
                        .padding(.top, UIScreen.main.bounds.height * 0.05)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                        
                    }
                    //MARK: Submit button
                    Button {
                        
                        
                        //start here
                        if listIndex == 8{
                            
                            getCabinetComponents()
                            
                            //Firebase data
                            
                            print("these are the cabinet components\(cabinetComponents)")
                            
                            //                    self.ref.child("Tested Cabinets").child(selection!).child("48V").setValue(1)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                                var counter = 0
                                var indexP = 0
                                
                                
                                while counter < cabinetComponents.count{
                                    
                                    print("begining of looop\(counter)")
                                    
                                    
                                    //!! Function that adds old quanitity of parts to new value of parts
                                    self.ref.child("Cabinets Requiring Testing").child(selection!).child(cabinetComponents[counter]).getData(completion:  { error, snapshot in
                                        guard error == nil else {
                                            print(error!.localizedDescription)
                                            return;
                                            let partQuantity = snapshot?.value as? Int ;
                                            
                                            
                                            
                                        }
                                        let partValue = snapshot?.value as? String ;
                                        
                                        
                                        
                                        
                                        self.ref.child("Tested Cabinets").child(selection!).child(cabinetComponents[indexP]).setValue(partValue)
                                        
                                        indexP += 1
                                        
                                        
                                    });
                                    
                                    print("current cabinet quanitiy\(cabinetComponents[counter])")
                                    
                                    print("current index \(counter)")
                                    
                                    counter += 1
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                                    let date = Date()
                                    
                                    self.ref.child("Tested Cabinets").child(selection!).child("Tested by").setValue("\(nameOfUser) on \(date.formatted())")
                                    
                                    self.ref.child("Cabinets Requiring Testing").child(selection!).removeValue()
                                    
                                }
                                print("These are the cabinet components\(self.cabinetComponents)")
                            }
                            getCabinetSerialNumber()
                            
                            
                        }else{
                            
                            if listIndex == 5{
                                //Hide the list view and show the the textfield view
                                
                                showList = false
                                showTextField = true
                                listIndex += 1
                                
                            }else if listIndex == 6 {
                                
                                showScrollView = true
                                showTextField = false
                                showList = false

                                listIndex += 1
                                
                            }else{
                                if testingCategoriesArray[listIndex].filter { $0.isCompleted }.count == testingCategoriesArray[listIndex].count{
                                    listIndex += 1
                                }else{
                                    showAlert.toggle()
                                }
                            }
                        }
                        
                    } label: {
                        Text("NEXT")
                            .tracking(3)
                            .font(.system(size: 30, weight: .light, design: .rounded))
                            .frame(width: UIScreen.main.bounds.width * 0.77, height: UIScreen.main.bounds.height * 0.02)
                            .foregroundColor(.white)
                            .padding(20.0)
                        
                    }.background(Color.black.opacity(1))
                        .cornerRadius(10)
                        .padding(.top, UIScreen.main.bounds.height * 0.015)
                    
                    
                }
                .padding(.top,UIScreen.main.bounds.height * listBounds)
                .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.51)
                .offset(y: UIScreen.main.bounds.height * -0.1)
                
                
                
                
                
                Spacer()
                
            }.onAppear {
                
                //MARK: Append all arrays into 2D Array
                testingCategoriesArray.append(eyecastCabinetExternalComponents)
                testingCategoriesArray.append(interiorComponents)
                testingCategoriesArray.append(poweredTesting)
                testingCategoriesArray.append(retrofitVerification)
                testingCategoriesArray.append(mikrotikFailOverBackCameraTest)
                testingCategoriesArray.append(labelling)
                
                
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
                    
                    
                    showList = true
                }
            }
            
            
            .alert(isPresented: $showAlert) {
                
                Alert(title: Text("⚠️"), message: Text("Please check that all the requirements are completed."), dismissButton: .default(Text("OK")))
                
            }
        }
        .actionSheet(isPresented: $showSheet) {
            ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                .default(Text("Photo Library")) {
                    self.showImagePicker = true
                    self.sourceType = .photoLibrary
                },
                .default(Text("Camera")) {
                    self.showImagePicker = true
                    self.sourceType = .camera
                },
                .cancel()
            ])
    }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
            
                .onDisappear {
                    if image != nil {
//                    imageArray.append(image!)
                        
                        
                        if imageArray[currentImageIndex].isEmpty{
                        imageArray[currentImageIndex] = image!
                        }else{
                            imageArray.insert(image!, at: currentImageIndex)

                        }
                    print("image was appended to the array ")
                        print(imageArray)
                    }
                    
                }
        }.onDisappear {
            
//            if image != nil {
//            imageArray.append(image!)
//            print("image was appended to the array ")
//            }
        }
    }
}

struct TestCabinetView_Previews: PreviewProvider {
    static var previews: some View {
        
        TestCabinetView(nameOfUser: "", currentImageIndex: 0).previewDevice("iPhone 13 Pro Max")
        TestCabinetView(nameOfUser: "", currentImageIndex: 0).previewDevice("iPhone 12")
        TestCabinetView(nameOfUser: "", currentImageIndex: 0).previewDevice("iPhone 8")
    }
}

//MARK: Task Object
struct Task: Identifiable {
    let id = UUID()
    let name: String
    var isCompleted: Bool
}


//MARK: Row View
struct TaskCellView: View {
    
    @Binding var task: Task
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.square": "square").resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .leading)
            
                .onTapGesture {
                    task.isCompleted.toggle()
                }
            Text(task.name)
        }
    }
}






