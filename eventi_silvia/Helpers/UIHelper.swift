//
//  UIHelper.swift
//  eventi_silvia
//
//  Created by iedstudent on 10/05/22.
//

import SwiftUI

struct UIHelper {
    static let primaryColor = Color(uiColor: UIColor(named:"baseColor")!)
    static let secondaryColor = Color(hex: 0x000000)
}


extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

