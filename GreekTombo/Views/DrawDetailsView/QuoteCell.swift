//
//  QuoteCell.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 6.8.24..
//

import Foundation

struct QuoteCell: Hashable {
    var firstRow: String
    var secondRow: String
    
    init(firstRow: String, secondRow: String) {
        self.firstRow = firstRow
        self.secondRow = secondRow
    }
}
