//
//  DrawsHistoryView.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation
import SwiftUI

struct DrawsHistoryView: View {
    
    @StateObject var viewModel: DrawsHistoryViewModel
    let gridLayout = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 5)
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            ScrollView {
                LazyVGrid(columns: gridLayout, spacing: 24) {
                    ForEach(viewModel.sections, id: \.self) { section in
                        Section(header: sectionHeaderView(section)) {
                            ForEach(section.winningNumbers, id: \.self) { data in
                                BallView(number: data.number, selected: data.selected, preventToggling: true, additionalInfo: data.order)
                            }
                        }.onAppear {
                            viewModel.loadNewPageIfNeeded(section: section)
                        }
                    }
                }.padding()
            }.refreshable(action: {
                viewModel.onScrollRefresh()
            })
        }
        .background(Color.dirtyWhite)
        .onAppear {
            viewModel.fetchScores(reload: true)
        }
    }
    
    
    @ViewBuilder
    func sectionHeaderView(_ section: ScoreSectionData) -> some View {
        VStack(spacing: 6) {
            Text(section.headerTitle)
                .bold()
            if let winningQuote = section.winningQuote {
                Text("Cestitamo! Dobitna kvota: \(String(winningQuote))")
                    .bold()
                    .italic()
                    .foregroundColor(.blue)
            }
        }.padding(.top, 40)
    }
}
