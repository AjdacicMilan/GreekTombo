//
//  DrawLiveView.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation
import SwiftUI

struct DrawLiveView: View {
    
    enum Constants {
        static let webUrl: String = "https://oldsite.mozzartbet.com/sr/lotto-animation/26/#"
    }
    
    @StateObject var viewModel: DrawLiveViewModel
    
    var body: some View {
        ZStack {
            Color.dirtyWhite
            if let url = URL(string: Constants.webUrl) {
                VStack(spacing: 0) {
                    WebView(url: url)
                    if let liveDraw = viewModel.liveDraw, viewModel.liveDrawNumbers.count > 1 {
                        footerView(draw: liveDraw, numbers: viewModel.liveDrawNumbers)
                    }
                }
            }
        }
        .background(Color.dirtyWhite)
        .onAppear {
            TimerManager.shared.appendDelegate(viewModel)
        }
        .onDisappear {
            TimerManager.shared.removeDelegate(viewModel)
        }
    }
    
    @ViewBuilder
    func footerView(draw: Draw, numbers: [Int]) -> some View {
        VStack(spacing: 2) {
            Text("Pratite Vase brojeve")
                .italic()
                .foregroundColor(.blue)
                .padding(.top, 8)
            Text("Vreme izvlacenja: \(draw.drawTime.displayTime()) | Kolo: \(String(draw.id))")
                .italic()
                .foregroundColor(.blue)
            CombinationView(numbers: numbers)
                .frame(height: 80)
            Divider()
        }
    }
}
