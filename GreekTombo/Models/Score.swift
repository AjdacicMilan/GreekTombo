//
//  Score.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 7.8.24..
//

import Foundation

struct Score: Decodable {
    var content: [Draw]
    
    enum CodingKeys: String, CodingKey {
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let contentValue = try? container.decode([Draw]?.self, forKey: CodingKeys.content)
        self.content = contentValue ?? []
    }
}
