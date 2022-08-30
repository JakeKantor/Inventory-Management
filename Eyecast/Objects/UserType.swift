//
//  UserType.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/24/22.
//

import Foundation
import SwiftUI
@MainActor class userType: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var userID = ""
    
}
