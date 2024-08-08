//
//  WinningNumbers.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 7.8.24..
//

import Foundation

struct WinningNumbers: Decodable {
    var list: [Int]
    
    enum CodingKeys: String, CodingKey {
        case list
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let listValue = try? container.decode([Int]?.self, forKey: CodingKeys.list)
        self.list = listValue ?? []
    }
}
