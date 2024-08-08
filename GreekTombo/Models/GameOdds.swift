//
//  GameOdds.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 6.8.24..
//

import Foundation

struct GameOdds: Decodable {
    
    static func prepareGameOddsDict() -> [Int:GameOdds] {
        if let path = Bundle.main.path(forResource: "BettingOdds", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        {
            let gameOddsArray = (try? JSONDecoder().decode([GameOdds].self, from: data)) ?? []
            var dict: [Int:GameOdds] = [:]
            gameOddsArray.forEach({
                dict[$0.gameType] = $0
            })
            return dict
        }
        return [:]
    }
    
    var gameType: Int
    var roundQuotesArray: [RoundQuote]
    var roundQuotesDict: [Int: Int]
    
    enum CodingKeys: String, CodingKey {
        case gameType, roundQuotes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gameType = try container.decode(Int.self, forKey: CodingKeys.gameType)
        roundQuotesArray = try container.decode([RoundQuote].self, forKey: CodingKeys.roundQuotes)
        roundQuotesDict = [:]
        roundQuotesArray.forEach({
            roundQuotesDict[$0.round] = $0.quote
        })
    }
}


struct RoundQuote: Decodable {
    var round: Int
    var quote: Int
}
