//
//  Draw.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation

struct Draw: Decodable, Identifiable {
    
    var id: Int
    var gameId: GameType
    var drawTime: Date
    var winningNumbers: WinningNumbers?
    
    enum CodingKeys: String, CodingKey {
        case id = "drawId", gameId, drawTime, winningNumbers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: CodingKeys.id)
        let gameIdValue = try container.decode(Int.self, forKey: CodingKeys.gameId)
        gameId = GameType(rawValue: gameIdValue) ?? .unknown
        let drawTimeTimestamp = try container.decode(TimeInterval.self, forKey: CodingKeys.drawTime)
        drawTime = Date(timeIntervalSince1970: drawTimeTimestamp/1000)
        winningNumbers = try? container.decode(WinningNumbers?.self, forKey: CodingKeys.winningNumbers)
    }
}
