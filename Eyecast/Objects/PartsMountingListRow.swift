//
//  PartsMountingListRow.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/29/22.
//

import SwiftUI

struct PartsMountingListRow: View {
    
    var part: PartandMounting
    
    var body: some View {
        
        HStack{
            Text(part.partName)
                .padding(.leading, UIScreen.main.bounds.width * 0.01)
                .font(.system(size: 20))

            Spacer()
            Text("\(part.quantityLeft) Left")
                .padding(.trailing, UIScreen.main.bounds.width * 0.02)
                .font(.system(size: 20))
            
            Image(systemName: "pencil.circle.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 25, alignment: .center)
                .padding(.trailing, UIScreen.main.bounds.width * 0.01)



        }
    }
}

struct PartsMountingListRow_Previews: PreviewProvider {
    static var previews: some View {
        PartsMountingListRow(part: PartandMounting(partName: "2 mm", partType: "Camera Parts", quantityLeft: 89)).previewLayout(.fixed(width: 500, height: 100))
    }
}
