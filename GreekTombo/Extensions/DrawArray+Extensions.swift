//
//  DrawArray+Extensions.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 8.8.24..
//

import Foundation

extension Array<Draw> {
    
    func closest(to referentMoment: Date) -> Draw? {
        var result: Draw?
        var minimumDistance: TimeInterval?
        for draw in self {
            let distance = abs(draw.drawTime.timeIntervalSince(referentMoment))
            if minimumDistance == nil || distance < minimumDistance! {
                minimumDistance = distance
                result = draw
            }
        }
        return result
    }
}
