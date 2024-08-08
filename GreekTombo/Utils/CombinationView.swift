//
//  CombinationView.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 7.8.24..
//

import Foundation
import SwiftUI

struct CombinationView: View {
    let numbers: [Int]
    var preventToggling: Bool = false
    var onPress: ((Int) -> Void)?
    let gridLayout = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 1)
    
    var body: some View {
        LazyHGrid(rows: gridLayout, spacing: 6) {
            ForEach(numbers.sorted(), id: \.self) {
                BallView(number: $0, selected: false, preventToggling: preventToggling, onPress: onPress)
            }
        }
    }
}
