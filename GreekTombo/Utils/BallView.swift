//
//  BallView.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 8.8.24..
//

import Foundation
import SwiftUI

struct BallView: View {
    
    let number: Int
    @State var selected: Bool
    var preventToggling: Bool
    var onPress: ((Int) -> Void)?
    var additionalInfo: String?
    
    var body: some View {
        Button(action: {
            onPress?(number)
            if !preventToggling {
                selected.toggle()
            }
        }, label: {
            ZStack {
                Text("\(String(number))")
                    .bold()
                    .foregroundColor(.black)
                    .frame(width: 56, height: 56)
                    .paint(number: number)
                    .cornerRadius(28)
                    .shadow(color: Color.shadowBlack, radius: 6, x: 0, y: 0)
                    .padding(4)
                
                if selected {
                    HandDrawnCircle()
                        .stroke(.blue, lineWidth: 2)
                        .background(HandDrawnCircle()
                            .fill(.clear))
                }
                
                if let additionalInfo {
                    Text(additionalInfo)
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                        .italic()
                        .offset(x: -20, y: -20)
                }
            }
        })
    }
}
