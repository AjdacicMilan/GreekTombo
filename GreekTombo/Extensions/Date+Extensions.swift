//
//  Date+Extensions.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation

extension Date {
    
    var remainingTimeDisplay: String {
        let totalSeconds = Int(ceil(timeIntervalSinceNow))
        let hours = max(totalSeconds / 3600, 0)
        let minutes = max((totalSeconds % 3600) / 60, 0)
        let seconds = max(totalSeconds % 60, 0)
        if hours == 0 {
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }
    
    var passed: Bool {
        self <= Date()
    }
    
    func passedIn(seconds: TimeInterval) -> Bool {
        self <= Date().addingTimeInterval(seconds)
    }
    
    func displayTime(_ dateFormatter: DateFormatter? = nil) -> String {
        (dateFormatter ?? DateFormatter.timeFormater).string(from: self)
    }
}
