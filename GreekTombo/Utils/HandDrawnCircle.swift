//
//  HandDrawnCircle.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 6.8.24..
//

import Foundation
import SwiftUI

struct HandDrawnCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        let points = 8
        let jitter: CGFloat = 2.0 // Increase jitter for a more pronounced hand-drawn effect
        
        // Use a for loop to create an imperfect circle
        for i in 0..<points {
            let angle = CGFloat(i) / CGFloat(points) * 2 * .pi
            let x = center.x + (radius + CGFloat.random(in: -jitter...jitter)) * cos(angle)
            let y = center.y + (radius + CGFloat.random(in: -jitter...jitter)) * sin(angle)
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        path.closeSubpath()
        return path
    }
}
