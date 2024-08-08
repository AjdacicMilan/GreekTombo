//
//  Color+Extensions.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation
import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    static let dirtyWhite = Color(red: 0.92, green: 0.92, blue: 0.92)
    static let shadowFill = Color(hex: 0x999999, opacity: 0.2)
    static let lightPink = Color(red: 0.81, green: 0.60, blue: 0.98)
    static let lightBlue = Color(hex: 0x1890FF)
    static let shadowBlack = Color.black.opacity(0.1)
}
