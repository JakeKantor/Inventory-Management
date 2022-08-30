//
//  EditPartsMountingView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/29/22.
//

import SwiftUI
import Firebase
import FirebaseDatabase
//Add textfield !!
struct EditPartsMountingView: View {
    
    var part: PartandMounting
    @State private var partsTotal = 1
    @State private var arrivalDate = Date()
    @State private var arrived = false
    
    //Variables for the long press features
    @State private var timer: Timer?
    @State var isLongPressing = false
    
    //Changes the color of the parts total
    @State private var isPartsTotalPositive = false

    //Creates the reference to the Realtime Database
    
    var ref = Database.database().reference()



    func switchColor(){
        if partsTotal > 0{
            isPartsTotalPositive = true
            //Change the color of the text and box to green and display the arrvial hstack
        }else if partsTotal < 0{
            isPartsTotalPositive = false

            //Change the color of the text and box to red and hide hstack

            
        }else if partsTotal == 0{
            isPartsTotalPositive = false

            //Change the color of the text and box to black and hide hstack

            
        }

        
        
    }
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.yellow,.orange], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            Rectangle()
                .fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.85))
                .frame(width: UIScreen.main.bounds.width * 0.95 , height: UIScreen.main.bounds.height * 0.80)
                .cornerRadius(20)
                .padding(.bottom, UIScreen.main.bounds.height * 0.07 )
            
            VStack{
               //Page title label
                Text("\(part.partName)")
                    .frame(width: UIScreen.main.bounds.width * 0.87, height: UIScreen.main.bounds.height * 0.012, alignment: .leading)
                    .foregroundColor(.black)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .padding(.top, (UIScreen.main.bounds.height * 0.06))
                    .padding(.bottom, (UIScreen.main.bounds.height * 0.05))
                //Parts total label
                HStack {

                    Text("\(partsTotal)")
                        .foregroundColor(isPartsTotalPositive ? .green : .red)

                        .bold()
                        .font(.system(size: 70))
                        .onAppear(){
                            switchColor()
                            
                        }

                    
                    
                }
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.12)
                .background(Rectangle().fill(Color.clear).shadow(radius: 3))
                .border((isPartsTotalPositive ? .green : .red), width: 5)
                .padding(.bottom,(UIScreen.main.bounds.height * 0.03))
                
                Button {
                    //add 1
                    switchColor()
                    
                    print("tap")
                                    if(self.isLongPressing){
                                        //this tap was caused by the end of a longpress gesture, so stop our fastforwarding
                                        self.isLongPressing.toggle()
                                        self.timer?.invalidate()
                                        
                                    } else {
                                        //just a regular tap
                                        self.partsTotal+=1

                                    }
                } label: {
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 0.0, green: 0.757, blue: 0.286, opacity: 1.0))
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.08)
                        Text("+").font(.system(size: 40, weight: .light, design: .rounded)).foregroundColor(.white)
                        
                        
                        
                        
                        
                    }
                }
                .padding(.bottom,UIScreen.main.bounds.height * 0.02)
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded { _ in
                               print("long press")
                               self.isLongPressing = true
                               //or fastforward has started to start the timer
                               self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                                   self.partsTotal += 1
                               })
                           })
                
                
                Button {
                    switchColor()
                    print("tap")
                                    if(self.isLongPressing){
                                        //this tap was caused by the end of a longpress gesture, so stop our fastforwarding
                                        self.isLongPressing.toggle()
                                        self.timer?.invalidate()
                                        
                                    } else {
                                        //just a regular tap
                                        self.partsTotal-=1

                                    }

                    
                    
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .fill(Color(red: 0.969, green: 0.337, blue: 0.337, opacity: 1.0))
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.08)
                        Text("-").font(.system(size: 60, weight: .light, design: .rounded)).foregroundColor(.white)
                    }
                }
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded { _ in
                               print("long press")
                               self.isLongPressing = true
                               //or fastforward has started to start the timer
                               self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                                   self.partsTotal -= 1
                               })
                           })

                //Row with Arrival date and selection for arrived or processing
                HStack{
                    //Datepicker to select pickup date
                    
                       
                    VStack(alignment: .leading) {
                       Text("Arrival Date")
                        DatePicker(selection: $arrivalDate) {
                           

                        }
                  .frame(width: 215, height: 30, alignment: .center)
                  .offset(x:-9)
                        
                        
                        



                    }
                    
                    
                        Toggle("Processing", isOn: $arrived)
                        .frame(width: 145, alignment: .center)
                        .padding(.top, UIScreen.main.bounds.height * 0.03)

                        
                      
                        
                        
                        



                    
                    
                }.opacity(isPartsTotalPositive ? 1 : 0)


                .frame(width: UIScreen.main.bounds.width * 0.50, height: 1, alignment: .center)
                .padding(.top,UIScreen.main.bounds.height * 0.05)
//                Text("This is \(part.partName) and there are \(part.quantityLeft) left.")
                
                Button{
                    
                    
                    //submit changes
                    
                    //!! Function that adds old quanitity of parts to new value of parts
                    self.ref.child("Inventory").child(part.partType).child(part.partName).child("Total Quantity").getData(completion:  { error, snapshot in
                        guard error == nil else {
                          print(error!.localizedDescription)
                          return;
                            let partValue = snapshot?.value as? Int ;

                            if partValue == nil{
                                self.ref.child("Inventory").child(part.partType).child(part.partName).child("Total Quantity").setValue(partsTotal)

                            
                            }
                            
                        
                        }
                        let partValue = snapshot?.value as? Int ;
                        
                        if partValue != nil{
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {

                                print("This is the part value stored\(partValue!+partsTotal)")
                                self.ref.child("Inventory").child(part.partType).child(part.partName).child("Total Quantity").setValue(partValue!+partsTotal)

                            }
                            
                        }

                      });
                   var statusOfOrder = ""
                    if arrived == true {
                        //Processing
                        statusOfOrder = "Processing"
                        
                    }else if arrived == false{
                        //Arrived
                        
                        statusOfOrder = "Arrived"


                        
                    }
                    self.ref.child("Inventory").child(part.partType).child(part.partName).child("Total Quantity").setValue(partsTotal)
                    self.ref.child("Inventory").child(part.partType).child(part.partName).child("Arrival Date: \(arrivalDate)").child("Quantity").setValue(partsTotal)
                    self.ref.child("Inventory").child(part.partType).child(part.partName).child("Arrival Date: \(arrivalDate)").child("Quantity").setValue(partsTotal)

                    self.ref.child("Inventory").child(part.partType).child(part.partName).child("Arrival Date: \(arrivalDate)").child("Status of Order").setValue("\(statusOfOrder)")


                    

                    
                    //                    self.ref.child("Inventory").child(part.partType).child(part.partName).child("Quantity").updateChildValues(updates)

                } label: {
                    ZStack{
                        Rectangle()
                            .fill(Color.black)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.08)
                        Text("SUBMIT CHANGE").font(.system(size: 20, weight: .light, design: .rounded)).foregroundColor(Color.white)
                            .tracking(2)





                    }
                }
                .padding(.top, 40)
                Spacer()
            }
            
            
        }
    }
}

struct EditPartsMountingView_Previews: PreviewProvider {
    static var previews: some View {
        EditPartsMountingView(part: PartandMounting(partName: "2 mm Lense",partType: "Camera Parts", quantityLeft: 74)).previewDevice("iPhone 13 Pro Max")
        EditPartsMountingView(part: PartandMounting(partName: "2 mm Lense",partType: "Camera Parts", quantityLeft: 74)).previewDevice("iPhone 12")
        EditPartsMountingView(part: PartandMounting(partName: "2 mm Lense",partType: "Camera Parts", quantityLeft: 74)).previewDevice("iPhone 8")
        
    }
}
