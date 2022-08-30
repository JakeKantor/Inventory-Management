//
//  TextBoxSmallFont.swift
//  Eyecast
//
//  Created by Jacob Kantor on 7/18/22.
//

import SwiftUI

struct TextBoxSmallFont: View {
    
    var textString: String
    
    
    var body: some View {
        
        HStack {
            Text(textString).foregroundColor(.black)
            Spacer().frame(width: 10)
            
            
            
            
        }
        .fixedSize(horizontal: false, vertical: false)
        .lineLimit(nil)
        .multilineTextAlignment(.center)
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.93, height: UIScreen.main.bounds.height * 0.05)
        .background(Rectangle().fill(Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.2)).shadow(radius: 3))
        .border(.black, width: 1.0)

    }
}

struct TextBoxSmallFont_Previews: PreviewProvider {
    static var previews: some View {
        TextBox(textString: "The kit does not work due to the various reasons. Reason 1......Reason 2.....Reason 3......").previewLayout(.fixed(width: UIScreen.main.bounds.width * 0.93, height: UIScreen.main.bounds.height * 0.05))
    }
}
