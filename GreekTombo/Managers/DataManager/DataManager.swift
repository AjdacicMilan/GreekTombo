//
//  DataManager.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 6.8.24..
//

import Foundation

class DataManager {
    
    static var shared = DataManager()
    
    var gameOddsDict: [Int:GameOdds]
    var draws: [Draw] {
        get {
            _draws
        }
        set {
            for drawItem in newValue {
                if !_draws.contains(where: { $0.id == drawItem.id }) {
                    _draws.append(drawItem)
                }
            }
        }
    }
    private var _draws: [Draw] = []
    
    var nextDraw: Draw? {
        for draw in draws {
            if !draw.drawTime.passedIn(seconds: 120) {
                return draw
            }
        }
        return nil
    }
    
    init() {
        self.gameOddsDict = GameOdds.prepareGameOddsDict()
    }
}
