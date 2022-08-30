//
//  PARTS:MOUNTINGOBJECT.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/29/22.
//

import SwiftUI

struct PartandMounting: Identifiable {
    var id = UUID()
    var partName: String
    var partType: String
    var quantityLeft: Int
}
