//
//  View+Extensions.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation
import SwiftUI

extension View {
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        self.modifier(FirstAppearModifier(action: action))
    }
    
    func shadow() -> some View {
        self.modifier(ShadowModifier())
    }
    
    func paint(number: Int) -> some View {
        self.modifier(BackgroundModifier(number: number))
    }
}
