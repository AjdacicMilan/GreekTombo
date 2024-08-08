//
//  BackgroundModifier.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 7.8.24..
//

import Foundation
import SwiftUI

struct BackgroundModifier: ViewModifier {
    
    let number: Int
    var color: Color {
        if number <= 20 {
            return .yellow
        } else if number > 20 && number <= 40 {
            return .lightPink
        } else if number > 40 && number <= 60 {
            return .lightBlue
        } else {
            return .red
        }
    }
    
    func body(content: Content) -> some View {
        let color = color
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.shadowBlack, color, Color.shadowBlack]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.shadowBlack, color, Color.shadowBlack]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}
