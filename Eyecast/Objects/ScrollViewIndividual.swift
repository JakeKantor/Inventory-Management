//
//  ScrollViewIndividual.swift
//  Eyecast
//
//  Created by Jacob Kantor on 7/29/22.
//

import SwiftUI

struct ScrollViewIndividual: View {
    @State var description: String

    
    
 var body: some View {
        ZStack {
            Circle()
                .fill(Color.yellow)
                .frame(width: 70, height: 70)
            Text(label)
        }
    }
}

struct ScrollViewIndividual_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewIndividual()
    }
}
