//
//  ViewIndividualKitView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 7/13/22.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct ViewIndividualKitView: View {
    
    
    var specficKitName: String
    @State var nameOfLocation: String
    @State var nameOfSubcontractor: String
    @State var thePickupDate: String
    @State var theCabinetNumber: String
    @State var theComment: String

    @State private var cabinetComponents: Array<String> = Array()
    @State private var cabinetComponentsValues: Array<String> = Array()
    @State var showLargeTextBox = false
    @State var theFontSize = 10.0

    @State private var presentAlert = false
    @State private var newComment: String = ""

    //Function Pulls all the components added to the cabinets requiring testing and stores in array
    func getCabinetComponents(){
        cabinetComponents.removeAll()
        
        //Array to the serial numbers
        ref.child("Kits").child(specficKitName).child("Cabinet Used").child(theCabinetNumber).observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children{
                
                let snap = child as! DataSnapshot
                let key = snap.key
                
                
                cabinetComponents.append("\(key)")
                
            }
            print(cabinetComponents)
        }
        
    }
    func getCabinetValues(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            var counter = 0
            var indexP = 0
            
            
            while counter < cabinetComponents.count{
                
                print("begining of looop\(counter)")
                
                
                //!! Function that adds old quanitity of parts to new value of parts
                ref.child("Kits").child(specficKitName).child("Cabinet Used").child(theCabinetNumber).child(cabinetComponents[counter]).getData(completion:  { error, snapshot in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return;
                        let partQuantity = snapshot?.value as? Int ;
                        
                        
                        
                    }
                    let partValue = snapshot?.value as? String ;
                    
                    print("This is the part value\(partValue)")
                    
                    cabinetComponentsValues.append(partValue!)
                    
                    
                    indexP += 1
                    
                    
                });
                
                
                
                counter += 1
                
                
            }
        }
    }
    
    
    
    
    var ref = Database.database().reference()

    
     func getKitData(){
        
        self.ref.child("Kits").child("\(specficKitName)").child("Location").getData { error, snapshot in
            
            var locationName = snapshot?.value as? String ;
            
            nameOfLocation = locationName!
            
        }
         
         self.ref.child("Kits").child("\(specficKitName)").child("Subcontractor").getData { error, snapshot in
             
             var subcontractorName = snapshot?.value as? String ;
             
             nameOfSubcontractor = subcontractorName!
             
         }
         
         
         self.ref.child("Kits").child("\(specficKitName)").child("Pickup Date").getData { error, snapshot in

             var pickUpDate = snapshot?.value as? String ;

             thePickupDate = pickUpDate!

         }
         
         self.ref.child("Kits").child("\(specficKitName)").child("Comments Made").getData { error, snapshot in

             var comment = snapshot?.value as? String ;

             theComment = comment!

         }
         
         
         
         
         //Array to the serial numbers
         ref.child("Kits").child("\(specficKitName)").child("Cabinet Used").observeSingleEvent(of: .value) { (snapshot) in
             for child in snapshot.children{

                 let snap = child as! DataSnapshot
                 let key = snap.key

                 theCabinetNumber = key

             }
         }

         
         
        
    }
    var body: some View {
        
        
        ZStack(){
            Color(red: 0.957, green: 0.906, blue: 0.824, opacity: 1.0).ignoresSafeArea()
            Rectangle()
                .fill(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0))
                .frame(width: UIScreen.main.bounds.width * 0.95 , height: UIScreen.main.bounds.height * 0.70)
                .cornerRadius(20)
                .padding(.bottom, UIScreen.main.bounds.height * 0.05 )
            
            VStack(alignment: .leading, spacing: 0, content: {
                
                
                Text(specficKitName)
                    .foregroundColor(.black)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding(.top, (UIScreen.main.bounds.height * 0.01))
                Spacer().frame(width: (UIScreen.main.bounds.width * 0.85 ), height: 1, alignment: .leading)
                
                
                
                TextBox(textString: "Location: \(nameOfLocation)")
                .padding(.top, (UIScreen.main.bounds.height * 0.01))
                TextBox(textString: "Subcontractor: \(nameOfSubcontractor)")
                .padding(.top, (UIScreen.main.bounds.height * 0.01))
                TextBox(textString: "Pickup Date: \(thePickupDate)")
                .padding(.top, (UIScreen.main.bounds.height * 0.01))
                
                Button {
                    
                    alrtTF(title: "Add Comment", message: "Please add comments about the kit here. To Delete Comment: Type None and Press Submit", hintText: "Explanation", primaryTitle: "Submit", secondaryTitle: "Cancel") { text in
                        print(text)
                        theComment = text
                        theFontSize = 10
                        self.ref.child("Kits").child("\(specficKitName)").child("Comments Made").setValue(text)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
                            if self.theComment == "None"{
                                self.theComment = "Select Button to Add Comment"
                                self.theFontSize = 24.0

                            }else {
                                self.theFontSize = 10.0

                            }
                            
                        }
                    } secondaryAction: {
                        print("Cancelled")
                    }

                } label: {
                    TextBoxSmallFont(textString: theComment)
                    .padding(.top, (UIScreen.main.bounds.height * 0.01))
                    .font(.system(size:theFontSize))
                    .fixedSize(horizontal: false, vertical: false)
                    .lineLimit(nil)


                }.onAppear {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                        if self.theComment == "None"{
                            self.theComment = "Select Button to Add Comment"
                            self.theFontSize = 24.0

                        }else {
                            self.theFontSize = 10.0

                        }
                        
                    }
                   
                }
                

                
             
                
                if showLargeTextBox{
                    LargeTextBox(textString: "Cabinet Number: \(theCabinetNumber)",ArrayData: cabinetComponents,ArrayValue: cabinetComponentsValues)
                    .padding(.top, (UIScreen.main.bounds.height * 0.02))
                    
                }





                Spacer()
                
            })
        }.onAppear {
            getKitData()
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                
                getCabinetComponents()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                
                getCabinetValues()
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                print("These are the cabsd comps \(cabinetComponents)")
                print("These are the cabsd values \(cabinetComponentsValues)")
                
                
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (_) in
                withAnimation {
                    self.showLargeTextBox = true
                }
            }
            
        }
    }
}

struct ViewIndividualKitView_Previews: PreviewProvider {
    static var previews: some View {
        ViewIndividualKitView(specficKitName: "A Kit", nameOfLocation: "Kendall", nameOfSubcontractor: "Eyecast", thePickupDate: "now", theCabinetNumber: "1111", theComment: "None")
    }
}

extension View{
    //MARK: Alert TF
    
    func alrtTF(title: String,message: String,hintText: String,primaryTitle: String,secondaryTitle: String,primaryAction: @escaping(String)->(),secondaryAction: @escaping ()->()){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = hintText
        }
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
            secondaryAction()
        }))
        
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            if let text = alert.textFields?[0].text{
                primaryAction(text)
                
            }else{
                primaryAction("")
                
            }
        }))
//MARK: Presenting Alert
        rootController().present(alert, animated: true, completion: nil)
    }
    
    //MARK; Root View Controller
    
    func rootController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            
            return.init()
        }
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        return root
    }
}
