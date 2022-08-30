//
//  LargeTextBox.swift
//  Eyecast
//
//  Created by Jacob Kantor on 7/15/22.
//

import SwiftUI

struct LargeTextBox: View {
    
    
    var textString: String
    var ArrayData: Array<String>
    var ArrayValue: Array<String>

    
    var body: some View {
        
        VStack {
            Text(textString).foregroundColor(.black).font(.system(size: 24))
            
            
            List {
                
                
                    
                    ForEach(0..<ArrayData.count, id: \.self) { index in
                        
                        HStack{
                            Text("\(self.ArrayData[index])")
                            Text(":")
                            Text("\(self.ArrayValue[index])")
                        
                        }
                        
                      
                    }
                
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.93, height: UIScreen.main.bounds.height * 0.24)
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
                
            }



            Spacer().frame(width: 10)
        }
//        .fixedSize(horizontal: false, vertical: true)
        .multilineTextAlignment(.center)
        .padding(.top)
        .frame(width: UIScreen.main.bounds.width * 0.93, height: UIScreen.main.bounds.height * 0.3)
        .background(Rectangle().fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.2)).shadow(radius: 3))
        .border(.black, width: 1.0)

    }
}

struct LargeTextBox_Previews: PreviewProvider {
    static var previews: some View {
        LargeTextBox(textString: "Cabinet Used: 5555", ArrayData: ["48V", "50V", "Created by", "Tested by"], ArrayValue: ["1", "1", "Jacob Kantor on 7/15/2022, 5:05 PM", "Jacob Kantor on 7/15/2022, 5:05 PM"])
            .previewLayout(.fixed(width: UIScreen.main.bounds.width * 0.93, height: UIScreen.main.bounds.height * 0.3))
    
    }
}
