//
//  Int+Extensions.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 6.8.24..
//

import Foundation

extension Int {
    var gameName: String? {
        if self < 2 {
            return nil
        } else {
            return "G\(String(self))"
        }
    }
    
    var gameTypePrefix: String {
        if self < 2 {
            return ""
        }
        let previous = self - 1
        if previous == 1 {
            return "1."
        }
        return "1.-\(previous)."
    }
}
