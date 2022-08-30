//
//  EyecastApp.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/20/22.
//

import SwiftUI
import Firebase

@main
struct EyecastApp: App {

    init(){
        
        FirebaseApp.configure()

    }

    var body: some Scene {
        WindowGroup {

        LoginView()
        }
    }
}
