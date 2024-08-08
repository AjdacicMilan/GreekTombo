//
//  UserDefaults+Extensions.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 7.8.24..
//

import Foundation

extension UserDefaults {
    
    static func getCombination(for drawId: Int) -> [Int] {
        (UserDefaults.standard.array(forKey: generateKey(for: drawId)) as? [Int]) ?? []
    }
    
    static func setCombination(for drawId: Int, numbers: [Int]) {
        UserDefaults.standard.set(numbers, forKey: generateKey(for: drawId))
    }
    
    private static func generateKey(for drawId: Int) -> String {
        "draw\(String(drawId))"
    }
}
