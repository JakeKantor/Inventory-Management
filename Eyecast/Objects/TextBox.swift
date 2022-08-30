//
//  TextBox.swift
//  Eyecast
//
//  Created by Jacob Kantor on 7/13/22.
//

import SwiftUI

struct TextBox: View {
    
    var textString: String
    
    
    var body: some View {
        
        HStack {
            Text(textString).foregroundColor(.black).font(.system(size: 24))
            
            Spacer().frame(width: 10)
            
            
            
            
        }
        .fixedSize(horizontal: false, vertical: true)
        .multilineTextAlignment(.center)
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.93, height: UIScreen.main.bounds.height * 0.05)
        .background(Rectangle().fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.2)).shadow(radius: 3))
        .border(.black, width: 1.0)

    }
}

struct TextBox_Previews: PreviewProvider {
    static var previews: some View {
        TextBox(textString: "Pickup Date: 70/29/2022,5:05 PM").previewLayout(.fixed(width: UIScreen.main.bounds.width * 0.93, height: UIScreen.main.bounds.height * 0.05))
    }
}
