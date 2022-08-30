//
//  SucessfullyCreatedView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 7/25/22.
//

import SwiftUI

struct SucessfullyCreatedView: View {
    
    var cabinetSerialNumber: String
    
    var body: some View {
        ZStack(){
            Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 0.95)
            VStack(){
                
                Text("Cabinet \(cabinetSerialNumber) was successfully created!")
                .font(.system(size: 35, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.center)

                Image(systemName: "checkmark.icloud.fill").resizable().scaledToFit()
                .frame(width: 150.0, height: 150.0)

            }
            
        }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.4, alignment: .center)
            .cornerRadius(20)
    }
}

struct SucessfullCreatedView_Previews: PreviewProvider {
    static var previews: some View {
        SucessfullyCreatedView(cabinetSerialNumber: "1001")
    }
}
