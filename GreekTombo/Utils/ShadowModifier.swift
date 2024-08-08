//
//  ShadowModifier.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 6.8.24..
//

import Foundation
import SwiftUI

struct ShadowModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.shadowFill, Color.dirtyWhite, Color.shadowFill]),
                    startPoint: .leading,
                    endPoint: .trailing
                ).cornerRadius(8)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.shadowFill, lineWidth: 0.5)
            )
    }
}
